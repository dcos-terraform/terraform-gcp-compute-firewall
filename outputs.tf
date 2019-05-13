# Cluster Name
output "name_prefix" {
  description = "Name Prefix"
  value       = "${var.cluster_name}"
}

# Network Name
output "network" {
  description = "Network Name"
  value       = "${var.network}"
}
