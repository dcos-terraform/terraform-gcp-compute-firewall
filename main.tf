provider "google" {}

resource "google_compute_firewall" "allow-load-balancer-health-checks" {
  name    = "${var.name_prefix}-allow-loadbalancer-access"
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
  name    = "${var.name_prefix}-internal-any-any"
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
  name    = "${var.name_prefix}-adminrouter-firewall"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["${var.admin_cidr}"]
  description   = "Used to allow HTTP and HTTPS access to DC/OS Adminrouter from the outside world specified by the user source range."
}

resource "google_compute_firewall" "ssh" {
  name    = "${var.name_prefix}-ssh"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["${var.admin_cidr}"]
  description   = "Used to allow SSH access to any instance from the outside world specified by the user source range."
}
