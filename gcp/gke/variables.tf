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

variable "subnetwork_id" {
  type = string
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
