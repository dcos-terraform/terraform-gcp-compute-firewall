# Cluster Name
variable "cluster_name" {
  description = "Cluster Name"
}

# Network Name
variable "network" {
  description = "network"
}

variable "internal_subnets" {
  description = "List of internal subnets to allow traffic between them"
  type        = "list"
}

variable "admin_ips" {
  description = "List of CIDR admin IPs"
  type        = "list"
}
