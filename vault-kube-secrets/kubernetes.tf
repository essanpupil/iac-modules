resource "kubernetes_service_account_v1" "kube_sa" {
  count = var.create_service_account ? 1 : 0
  metadata {
    name      = var.service_account_name
    namespace = var.kubernetes_namespace
  }
}

resource "kubernetes_cluster_role_binding_v1" "kube_rb" {
  metadata {
    name = var.cluster_role_binding_name == "" ? "${var.service_account_name}-rb" : var.cluster_role_binding_name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }
  subject {
    kind      = "ServiceAccount"
    name      = var.create_service_account ? kubernetes_service_account_v1.kube_sa[0].metadata[0].name : var.service_account_name
    namespace = var.kubernetes_namespace
  }
}

resource "kubernetes_manifest" "vault_auth" {
  manifest = yamldecode(<<EOF
    apiVersion: secrets.hashicorp.com/v1beta1
    kind: VaultAuth
    metadata:
      namespace: ${var.kubernetes_namespace}
      name: ${var.vault_auth_name == "" ? var.vault_role_name : var.vault_auth_name}
    spec:
      method: kubernetes
      mount: ${var.kubernetes_path}
      kubernetes:
        role: ${vault_kubernetes_auth_backend_role.this.role_name}
        serviceAccount: ${var.create_service_account ? kubernetes_service_account_v1.kube_sa[0].metadata[0].name : var.service_account_name}
        audiences:
          - "https://kubernetes.default.svc.cluster.local"
  EOF
  )
}

resource "kubernetes_manifest" "vault_static_secret" {
  count = length(var.vault_kv_secrets)
  manifest = yamldecode(<<EOF
    apiVersion: secrets.hashicorp.com/v1beta1
    kind: VaultStaticSecret
    metadata:
      namespace: ${var.kubernetes_namespace}
      name: ${var.vault_kv_secrets[count.index].vault_static_name}
    spec:
      vaultAuthRef: ${kubernetes_manifest.vault_auth.object.metadata.name}
      mount: ${var.kv_secret_path}
      type: kv-v2
      path: ${var.vault_kv_secrets[count.index].name}
      version: 2
      refreshAfter: 10s
      destination:
        create: true
        name: ${var.vault_kv_secrets[count.index].name}
        overwrite: true
        type: ${var.vault_kv_secrets[count.index].type}
    EOF
  )
}
