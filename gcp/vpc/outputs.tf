output "network_id" {
  value = google_compute_network.this.id
}

output "network_name" {
  value = google_compute_network.this.name
}

output "private_subnetworks" {
  value = google_compute_subnetwork.private_subnetwork[*].id
}
