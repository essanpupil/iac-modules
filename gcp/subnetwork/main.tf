resource "google_compute_subnetwork" "this" {
  project                  = var.project_id
  name                     = var.name
  ip_cidr_range            = var.ip_cidr_range
  region                   = var.region
  network                  = var.network_id
  private_ip_google_access = true


  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_router" "router" {
  project = var.project_id
  name    = "${var.name}-router"
  region  = var.region
  network = var.network_id
}

resource "google_compute_router_nat" "nat" {
  project = var.project_id
  name    = "${var.name}-nat"
  router  = google_compute_router.router.name
  region  = var.region

  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
