variable "release_name" {
  type = string
}

variable "repository" {
  type = string
}

variable "chart" {
  type = string
}

variable "chart_version" {
  type    = string
  default = null
}

variable "atomic" {
  type    = bool
  default = true
}

variable "wait" {
  type    = bool
  default = true
}

variable "create_namespace" {
  type    = bool
  default = false
}

variable "namespace_name" {
  type    = string
  default = null
}
