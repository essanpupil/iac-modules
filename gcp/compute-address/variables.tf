variable "project_id" {
  description = "The ID of the project"
  type        = string
}

variable "name" {
  description = "The name of the reserved address"
  type        = string
}

variable "scope" {
  description = <<-EOT
    Whether the address is regional or global.

    Use GLOBAL for a GKE Ingress / Gateway external Application Load Balancer
    (ingressClassName `gce` or `gke-iap`), and REGIONAL for a regional external
    Application Load Balancer.
  EOT
  type        = string
  default     = "REGIONAL"

  validation {
    condition     = contains(["REGIONAL", "GLOBAL"], var.scope)
    error_message = "scope must be either REGIONAL or GLOBAL."
  }
}

variable "region" {
  description = "The region in which to reserve a REGIONAL address. Ignored when scope is GLOBAL."
  type        = string
  default     = null
}

variable "address_type" {
  description = "Whether the address is reachable from the internet (EXTERNAL) or only from Google Cloud (INTERNAL)."
  type        = string
  default     = "EXTERNAL"

  validation {
    condition     = contains(["EXTERNAL", "INTERNAL"], var.address_type)
    error_message = "address_type must be either EXTERNAL or INTERNAL."
  }
}

variable "ip_version" {
  description = "The IP version of the address."
  type        = string
  default     = "IPV4"

  validation {
    condition     = contains(["IPV4", "IPV6"], var.ip_version)
    error_message = "ip_version must be either IPV4 or IPV6."
  }
}

variable "network_tier" {
  description = <<-EOT
    The network tier of a REGIONAL address. Ignored when scope is GLOBAL, where
    the address is always PREMIUM. Regional EXTERNAL addresses backing a load
    balancer must also be PREMIUM; STANDARD is only valid for addresses not
    used by a load balancer.
  EOT
  type        = string
  default     = "PREMIUM"

  validation {
    condition     = contains(["PREMIUM", "STANDARD"], var.network_tier)
    error_message = "network_tier must be either PREMIUM or STANDARD."
  }
}

variable "subnetwork" {
  description = "The subnetwork to attach a REGIONAL address to. Ignored when scope is GLOBAL."
  type        = string
  default     = null
}

variable "description" {
  description = "Human readable description of the address."
  type        = string
  default     = null
}
