# Cluster Name
output "name_prefix" {
  description = "Cluster Name"
  value       = "${var.name_prefix}"
}

# Network Name
output "network" {
  description = "network"
  value       = "${var.network}"
}
