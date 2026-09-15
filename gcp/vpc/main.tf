resource "google_compute_network" "this" {
  # checkov:ignore:CKV2_GCP_18
  project                 = var.project_id
  name                    = var.network_name
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

resource "google_compute_firewall" "allow_web" {
  project       = var.project_id
  name          = "jagat-allow-web"
  network       = google_compute_network.this.name
  source_ranges = ["10.2.0.0/16"]
  source_tags   = ["jagat"]

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
}

module "private_subnetworks" {
  count         = length(var.private_subnets)
  source        = "/Users/essan/Code/iac-modules/gcp/subnetwork"
  project_id    = var.project_id
  name          = var.private_subnets[count.index].name
  region        = var.private_subnets[count.index].region
  ip_cidr_range = var.private_subnets[count.index].ip_cidr_range
  network_id    = google_compute_network.this.id
}
