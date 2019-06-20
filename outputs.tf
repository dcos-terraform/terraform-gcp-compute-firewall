output "cluster_name" {
  description = "Name of the DC/OS cluster"
  value       = "${var.cluster_name}"
}

output "network" {
  description = "Network Name"
  value       = "${var.network}"
}
