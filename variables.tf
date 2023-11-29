variable "network" {
  type        = string
  description = "Name of the network"
}
variable "subnetwork" {
  type        = string
  description = "Name of the subnetwork"
}
variable "region" {
  type        = string
  description = "Region to deploy the resources to"
}
variable "db_name" {
  type        = string
  description = "Cloud SQL instance database name"
}
variable "project" {
  type        = string
  description = "Project name where the resources are deployed"
}
variable "create_firewall_rule" {
  type        = bool
  description = "Boolean to enable/disable firewall rule creation for IAP tunnelling"
  default     = false
}
variable "additional_ports" {
  type        = list(string)
  description = "Additional ports to open for IAP tunnelling - only used if create_firewall_rule is true"
  default     = []
}
variable "members" {
  description = "List of the members to grant IAM permissions for IAP tunnelling. Format: user:<email>, group:<email>, etc."
  type        = list(string)
}
variable "host_project" {
  description = "Project where the firewall rule + VM will be created if using Shared VPC - if not using Shared VPC leave blank"
  type        = string
  default     = ""
}
variable "cloud_sql_proxy_version" {
  description = "Version of the Cloud SQL Proxy to download"
  type        = string
  default     = "v2.7.2"
}
variable "psc_connection" {
  description = "Set this to true to connect to your Cloud SQL instance via Private Service Connect. default will connect to SQL via private IP."
  type        = bool
  default     = false
}