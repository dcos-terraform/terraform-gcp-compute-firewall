# Cluster Name
output "name_prefix" {
  value = "${var.name_prefix}"
}

# Network Name
output "network" {
  value = "${var.network}"
}

# List of allowed IPs to access DCOS cluster
output "admin_cidr" {
  value = "${var.admin_cidr}"
}
