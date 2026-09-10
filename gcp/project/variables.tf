variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "billing_account" {
  description = "Billing account"
  type        = string
  default     = ""
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
  default     = ""
}

variable "org_id" {
  description = "Organization ID"
  type        = string
  default     = ""
}

variable "auto_create_network" {
  type    = bool
  default = false
}
