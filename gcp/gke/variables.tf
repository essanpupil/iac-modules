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
