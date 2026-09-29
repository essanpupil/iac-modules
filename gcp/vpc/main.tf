resource "google_compute_network" "this" {
  # checkov:ignore:CKV2_GCP_18
  project                 = var.project_id
  name                    = var.network_name
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

module "private_subnetworks" {
  count         = length(var.private_subnets)
  source        = "../subnetwork"
  project_id    = var.project_id
  name          = var.private_subnets[count.index].name
  region        = var.private_subnets[count.index].region
  ip_cidr_range = var.private_subnets[count.index].ip_cidr_range
  network_id    = google_compute_network.this.id
}
