output "network_id" {
  value = google_compute_network.jagat.id
}

output "subnetworks" {
  value = {
    for k, v in google_compute_subnetwork.private_subnetwork : k => v.id
  }
}
