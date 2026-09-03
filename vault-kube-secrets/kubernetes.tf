resource "kubernetes_service_account_v1" "kube_sa" {
  metadata {
    name      = "${var.vault_role_name}-sa"
    namespace = var.kubernetes_namespace
  }
}

resource "kubernetes_cluster_role_binding_v1" "kube_rb" {
  metadata {
    name = "${var.vault_role_name}-rb"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.kube_sa.metadata[0].name
    namespace = var.kubernetes_namespace
  }
}

resource "kubernetes_manifest" "vault_auth" {
  manifest = yamldecode(<<EOF
    apiVersion: secrets.hashicorp.com/v1beta1
    kind: VaultAuth
    metadata:
      namespace: ${var.kubernetes_namespace}
      name: ${var.vault_role_name}-auth
    spec:
      method: kubernetes
      mount: ${var.kubernetes_path}
      kubernetes:
        role: ${vault_kubernetes_auth_backend_role.this.role_name}
        serviceAccount: ${kubernetes_service_account_v1.kube_sa.metadata[0].name}
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
      name: ${var.vault_kv_secrets[count.index].name}
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
