# Cluster Name
variable "name_prefix" {}

# Network Name
variable "network" {}

# Instances Self Link
variable "instances_self_link" {
  type = "list"
}

# DCOS Role
variable "dcos_role" {}

# List of allowed IPs to access DCOS cluster
variable "admin_cidr" {
  default = "0.0.0.0/0"
}
