locals {
  is_global = var.scope == "GLOBAL"
}

resource "google_compute_address" "this" {
  count = local.is_global ? 0 : 1

  project      = var.project_id
  name         = var.name
  region       = var.region
  ip_version   = var.ip_version
  address_type = var.address_type
  network_tier = var.network_tier
  subnetwork   = var.subnetwork
  description  = var.description
}

# google_compute_global_address does not accept network_tier, region or
# subnetwork: a global address is always PREMIUM, which is what global load
# balancers require.
resource "google_compute_global_address" "this" {
  count = local.is_global ? 1 : 0

  project      = var.project_id
  name         = var.name
  ip_version   = var.ip_version
  address_type = var.address_type
  description  = var.description
}
