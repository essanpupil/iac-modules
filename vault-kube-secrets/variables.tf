variable "create_service_account" {
  type = bool
}

variable "service_account_name" {
  type    = string
  default = ""
}

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
    vault_static_name = string
    name              = string
    type              = string
    data              = map(string)
  }))
}

variable "vautl_policy_name" {
  type    = string
  default = ""
}

variable "vault_auth_name" {
  type    = string
  default = ""
}

variable "cluster_role_binding_name" {
  type    = string
  default = ""
}
