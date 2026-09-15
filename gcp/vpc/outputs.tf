output "network_id" {
  value = google_compute_network.this.id
}

output "network_name" {
  value = google_compute_network.this.name
}

output "private_subnetworks_id" {
  value = module.private_subnetworks[*].subnetwork_ids
}

output "private_subnetworks_name" {
  value = module.private_subnetworks[*].subnetwork_names
}
