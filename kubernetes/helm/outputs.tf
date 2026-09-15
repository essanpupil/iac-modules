output "namespace_name" {
  value = var.create_namespace == true ? kubernetes_namespace_v1.this[0].metadata[0].name : var.namespace_name
}
