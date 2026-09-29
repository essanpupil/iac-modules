resource "google_compute_firewall" "this" {
  project       = var.project_id
  name          = var.name
  network       = var.network
  source_ranges = var.source_ranges
  source_tags   = var.source_tags
  direction = var.direction

  dynamic "allow" {
    for_each = var.allow
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }
}
