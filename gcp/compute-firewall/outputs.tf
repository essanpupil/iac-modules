output "id" {
  description = "The fully-qualified ID of the firewall rule"
  value       = google_compute_firewall.this.id
}

output "name" {
  description = "The name of the firewall rule"
  value       = google_compute_firewall.this.name
}
