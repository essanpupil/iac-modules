resource "google_compute_firewall" "allow_ssh" {
  count         = var.allow_ssh ? 1 : 0
  project       = var.project_id
  name          = "${var.name}-ingress-ssh"
  network       = var.network_name
  direction     = "INGRESS"
  priority      = 1000
  source_ranges = var.ssh_source_range

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  description = "Allows SSH traffic from the corporate office network."
  target_tags = ["bastion"]
}

resource "google_compute_instance" "bastion" {
  project      = var.project_id
  name         = var.name
  machine_type = "e2-micro"
  zone         = var.zone
  tags = ["bastion"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-13"
    }
  }
  network_interface {
    subnetwork = var.subnetwork_id
    access_config {
    }
  }
}
