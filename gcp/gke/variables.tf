variable "name" {
  type = string
}

variable "location" {
  type    = string
  default = "us-central1"
}

variable "network_id" {
  type = string
}

variable "network_name" {
  type = string
}

variable "subnetwork_id" {
  type    = string
  default = null
}

variable "subnetwork_name" {
  type    = string
  default = null
}

variable "service_account_id" {
  type = string
}

variable "service_account_description" {
  type    = string
  default = null
}

variable "project_id" {
  type = string
}

variable "network_policy_enabled" {
  type    = bool
  default = false
}

variable "network_policy_provider" {
  type    = string
  default = "PROVIDER_UNSPECIFIED"
}

variable "enable_cilium_clusterwide_network_policy" {
  type    = bool
  default = true
}

variable "datapath_provider" {
  type    = string
  default = "ADVANCED_DATAPATH"
}

variable "addons_network_policy_config" {
  type    = bool
  default = true
}

variable "bastion_zone" {
  type    = string
  default = "a"
}

variable "ssh_source_range" {
  type    = list(string)
  default = [""]
}

variable "create_bastion" {
  type = bool
}

variable "enable_private_endpoint" {
  type    = bool
  default = true
}

variable "gcp_public_cidrs_access_enabled" {
  type    = bool
  default = false
}

variable "public_authorized_cidr" {
  type    = string
  default = "127.0.0.1/32"
}

variable "enabled_secret_manager_config" {
  type    = bool
  default = false
}
