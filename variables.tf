variable "network" {
    type = string
    description = "Name of the network/VPC"
}
variable "subnetwork" {
    type = string
    description = "Name of the subnetwork"
}
variable "region" {
    type = string
    description = "Region to deploy the resources to"
}
variable "db_name" {
    type = string
    description = "Cloud SQL instance database name"
}
variable "project" {
    type = string
    description = "Project name to deploy the resources to"
}
variable "create_firewall_rule" {
    type = bool
    description = "Boolean to enable/disable firewall rule creation for IAP tunnelling"
    default = false
}
variable "additional_ports" {
    type = list(string)
    description = "Additional ports to open for IAP tunnelling - only used if create_firewall_rule is true"
    default = []
}
variable "members" {
    description = "List of the members to grant IAM permissions for IAP tunnelling"
    type = list(string)
}
variable "host_project" {
    description = "Project where the firewall rule will be created if using Shared VPC - if not using Shared VPC leave blank"
    type = string
    default = ""
}