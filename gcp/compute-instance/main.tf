resource "google_compute_firewall" "allow_ssh" {
  count         = var.allow_ssh ? 1 : 0
  project       = var.project_id
  name          = "${var.name}-ingress-ssh"
  network       = var.network_name
  direction     = "INGRESS"
  priority      = 1000
  source_ranges = var.ssh_source_range
  target_tags   = [var.name]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  description = "Allows SSH traffic from the corporate office network."
}

resource "google_compute_instance" "this" {
  project      = var.project_id
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone == null ? data.google_compute_zones.zones.names[0] : var.zone
  tags         = [var.name]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-13"
    }
  }
  network_interface {
    subnetwork = var.subnetwork_id

    dynamic "access_config" {
      for_each = var.assign_public_ip ? [true] : []
      content {}
    }
  }
}
