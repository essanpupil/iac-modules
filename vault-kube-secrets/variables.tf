variable "vault_role_name" {
  type = string
}

variable "kubernetes_path" {
  type = string
}

variable "kubernetes_namespace" {
  type = string
}

variable "kv_secret_path" {
  type = string
}

variable "vault_kv_secrets" {
  type = list(object({
    name = string
    type = string
    data = map(string)
  }))
}
