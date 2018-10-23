# Cluster Name
output "name_prefix" {
  description = "Cluster Name"
  value       = "${var.cluster_name}"
}

# Network Name
output "network" {
  description = "Network Name"
  value       = "${var.network}"
}
