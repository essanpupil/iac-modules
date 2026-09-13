variable "project_id" {
  type = string
}

variable "name" {
  type = string
}

variable "zone" {
  type = string
}

variable "subnetwork_id" {
  type = string
}

variable "allow_ssh" {
  type = bool
}

variable "network_name" {
  type = string
}

variable "ssh_source_range" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
