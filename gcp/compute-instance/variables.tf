variable "project_id" {
  type = string
}

variable "name" {
  type = string
}

variable "zone" {
  type = string
  default = null
}

variable "machine_type" {
  description = "The machine type for the instance"
  type        = string
  default     = "e2-micro"
}

variable "subnetwork_id" {
  type = string
}

variable "assign_public_ip" {
  description = "Whether to assign an external IP address to the instance"
  type        = bool
  default     = true
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

variable "region" {
  type = string
  default = null
}
