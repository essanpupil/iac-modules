resource "vault_kv_secret_v2" "this" {
  count     = length(var.vault_kv_secrets)
  mount     = var.kv_secret_path
  name      = var.vault_kv_secrets[count.index].name
  data_json = jsonencode(var.vault_kv_secrets[count.index].data)
}

resource "vault_policy" "this" {
  depends_on = [vault_kv_secret_v2.this]
  name       = var.vautl_policy_name == "" ? "${var.vault_role_name}-policy" : var.vautl_policy_name
  policy     = data.vault_policy_document.this.hcl
}

resource "vault_kubernetes_auth_backend_role" "this" {
  backend                          = var.kubernetes_path
  role_name                        = var.vault_role_name
  bound_service_account_names      = [var.create_service_account ? kubernetes_service_account_v1.kube_sa[0].metadata[0].name : var.service_account_name]
  bound_service_account_namespaces = [var.kubernetes_namespace]
  token_policies                   = [vault_policy.this.name]
  token_ttl                        = 1800 # 30 minutes
}
