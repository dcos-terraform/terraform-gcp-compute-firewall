# Cluster Name
output "name_prefix" {
  value = "${var.name_prefix}"
}

# Network Name
output "network" {
  value = "${var.network}"
}

# Instances Self Link
output "instances_self_link" {
  value = "${var.instances_self_link}"
}

# DCOS Role
output "dcos_role" {
  value = "${var.dcos_role}"
}

# List of allowed IPs to access DCOS cluster
output "admin_cidr" {
  value = "${var.admin_cidr}"
}
