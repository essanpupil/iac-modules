output "address" {
  description = "The reserved IP address"
  value       = local.is_global ? google_compute_global_address.this[0].address : google_compute_address.this[0].address
}

output "id" {
  description = "The fully-qualified ID of the address resource"
  value       = local.is_global ? google_compute_global_address.this[0].id : google_compute_address.this[0].id
}

output "name" {
  description = "The name of the address resource"
  value       = local.is_global ? google_compute_global_address.this[0].name : google_compute_address.this[0].name
}
