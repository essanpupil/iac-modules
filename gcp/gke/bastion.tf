resource "google_compute_instance" "bastion" {
  project      = var.project_id
  name         = "${var.name}-bastion"
  machine_type = "e2-micro"
  zone         = "${var.location}-${var.bastion_zone}"
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
