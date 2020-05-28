variable "cluster_name" {}
variable "internal_subnets" {
  type = list(string)
}
variable "admin_ips" {
  type = list(string)
}



locals {
  name = "terratest-compute-firewall-${var.cluster_name}"
}

resource "google_compute_network" "network" {
  name                    = "${local.name}-network"
  auto_create_subnetworks = "false"
}

## Two subnetworks (masters, agents)
resource "google_compute_subnetwork" "subnet" {
  name          = "${local.name}-subnet"
  ip_cidr_range = element(var.internal_subnets, 0)
  network       = google_compute_network.network.self_link
}

module "dcos-compute-firewall" {
  source           = "../../"
  cluster_name     = var.cluster_name
  network          = google_compute_network.network.self_link
  internal_subnets = var.internal_subnets
  admin_ips        = var.admin_ips
}

output "network_name" {
  value = google_compute_network.network.name
}
