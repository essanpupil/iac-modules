variable "project_id" {
  description = "The ID of the project"
  type        = string
}

variable "name" {
  description = "The name of the firewall rule"
  type        = string
}

variable "network" {
  description = "The network to attach the firewall rule to"
  type        = string
}

variable "source_ranges" {
  description = "The source IP ranges that the firewall rule applies to"
  type        = list(string)
}

variable "source_tags" {
  description = "The source instance tags that the firewall rule applies to"
  type        = list(string)
  default = []
}

variable "allow" {
  description = "The protocols and ports allowed by the firewall rule"
  type = list(object({
    protocol = string
    ports    = list(string)
  }))
}

variable "direction" {
  type = string
  default = null
}
