variable "project_id" {
  description = "The ID of the project"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "additional_tags" {
  description = "The list of additional tags"
  type        = map(string)
  default     = {}
}

variable "private_subnets" {
  description = "The list of subnets"
  type = list(object({
    name          = string
    ip_cidr_range = string
    region        = string
  }))
}
