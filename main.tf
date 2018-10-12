/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-compute-firewall/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-gcp-compute-firewall/job/master/)
 * # DC/OS Network Firewall Rules
 *
 * The firewall module creates four different policies to be used by provisioning DC/OS Infrastructure
 *
 * ## EXAMPLE
 *
 * ```hcl
 * module "dcos-compute-firewall" {
 *   source  = "dcos-terraform/compute-firewall/gcp"
 *   version = "~> 0.1"
 *
 *   network = "network_self_link"
 *   internal_subnets = "172.12.0.0/16"
 *   admin_ips = ["1.2.3.4/32"]
 * }
 * ```
 */

provider "google" {}

resource "google_compute_firewall" "allow-load-balancer-health-checks" {
  name    = "${var.cluster_name}-allow-loadbalancer-access"
  network = "${var.network}"

  allow {
    protocol = "tcp"
  }

  # The health check probes to your load balanced instances come from addresses
  # in range 130.211.0.0/22 and 35.191.0.0/16.
  # See https://cloud.google.com/load-balancing/docs/health-checks#https_ssl_proxy_tcp_proxy_and_internal_load_balancing  # for more details
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}

resource "google_compute_firewall" "internal-any-any" {
  name    = "${var.cluster_name}-internal-any-any"
  network = "${var.network}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "tcp"
  }

  source_ranges = ["${var.internal_subnets}"]
  description   = "Used to allow internal access to all servers."
}

resource "google_compute_firewall" "adminrouter" {
  name    = "${var.cluster_name}-adminrouter-firewall"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["${var.admin_ips}"]
  description   = "Used to allow HTTP and HTTPS access to DC/OS Adminrouter from the outside world specified by the user source range."
}

resource "google_compute_firewall" "ssh" {
  name    = "${var.cluster_name}-ssh"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["${var.admin_ips}"]
  description   = "Used to allow SSH access to any instance from the outside world specified by the user source range."
}

resource "google_compute_firewall" "public-agents" {
  name    = "${var.cluster_name}-public-agents"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["${concat(list("80", "443"),var.public_agents_additional_ports)}"]
  }

  source_ranges = ["${var.public_agents_ips}"]
  target_tags   = ["${var.cluster_name}-public-agents"]

  description = "Allow acces to public agents."
}
