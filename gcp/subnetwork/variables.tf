variable "project_id" {
  type = string
}

variable "name" {
  type = string
}

variable "ip_cidr_range" {
  type = string
}

variable "region" {
  type = string
}

variable "network_id" {
  type = string
}

variable "enable_private_ip_google_access" {
  description = "Enable access to Google APIs from instances without external IP addresses."
  type        = bool
  default     = true
}

variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs for this subnetwork."
  type        = bool
  default     = true
}

variable "flow_logs_aggregation_interval" {
  description = "Interval at which flow logs are aggregated."
  type        = string
  default     = "INTERVAL_10_MIN"
}

variable "flow_logs_sampling" {
  description = "Fraction of sampled packets to include in flow logs, from 0.0 to 1.0."
  type        = number
  default     = 0.5
}

variable "flow_logs_metadata" {
  description = "Metadata fields to include in flow logs."
  type        = string
  default     = "INCLUDE_ALL_METADATA"
}
