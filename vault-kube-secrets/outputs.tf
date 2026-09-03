output "service_account_name" {
  value = var.create_service_account ? kubernetes_service_account_v1.kube_sa[0].metadata[0].name : var.service_account_name
}
