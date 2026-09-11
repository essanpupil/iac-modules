output "network_id" {
  value = google_compute_network.jagat.id
}

output "private_subnetworks" {
  value = google_compute_subnetwork.private_subnetwork[*].id
}
