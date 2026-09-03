data "vault_policy_document" "this" {
  dynamic "rule" {
    for_each = var.vault_kv_secrets
    content {
      path         = "${var.kv_secret_path}/data/${var.vault_kv_secrets[rule.key].name}"
      capabilities = ["create", "read"]
      description  = "Create and read secrets"
    }
  }
}
