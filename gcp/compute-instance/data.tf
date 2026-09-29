data "google_compute_zones" "zones" {
  project = var.project_id
  region  = var.region
  status  = "UP"
}
