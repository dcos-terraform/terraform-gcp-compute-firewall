# Cluster Name
variable "name_prefix" {}

# Network Name
variable "network" {}

variable "internal_subnets" {
  description = "List of internal subnets to allow traffic between them"
  type        = "list"
}

variable "admin_ips" {
  description = "List of CIDR ips for admin access"
  type        = "list"
}
