# Cluster Name
variable "name_prefix" {}

# Network Name
variable "network" {}

variable "internal_subnets" {
  description = "List of internal subnets to allow traffic between them"
  type        = "list"
}

# List of allowed IPs to access DCOS cluster
variable "admin_cidr" {}
