resource "kubernetes_namespace_v1" "this" {
  count = var.create_namespace ? 1 : 0
  metadata {
    name = var.namespace_name
  }
}

resource "helm_release" "this" {
  name       = var.release_name
  repository = var.repository
  chart      = var.chart
  namespace  = var.create_namespace == true ? kubernetes_namespace_v1.this[0].metadata[0].name : var.namespace_name
  version    = var.chart_version
  atomic     = var.atomic
  wait       = var.wait
}
