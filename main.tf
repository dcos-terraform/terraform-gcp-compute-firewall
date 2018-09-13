provider "google" {}

# Reserving the Public IP Address of the External Load Balancer for the node
resource "google_compute_address" "node" {
  name = "${var.name_prefix}-ext-${var.dcos_role}-node-addr"
}

resource "google_compute_firewall" "allow-health-checks" {
  name    = "${var.name_prefix}-${var.dcos_role}-health-chk"
  network = "${var.network}"

  allow {
    protocol = "tcp"
  }

  # The health check probes to your load balanced instances come from addresses in range 130.211.0.0/22 and 35.191.0.0/16.
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
}

resource "google_compute_forwarding_rule" "external-node-forwarding-rule-http" {
  name                  = "${var.name_prefix}-${var.dcos_role}-ext-lb-rule-http"
  load_balancing_scheme = "EXTERNAL"
  target                = "${google_compute_target_pool.node-pool.self_link}"
  port_range            = "80"
  ip_address            = "${google_compute_address.node.address}"
  depends_on            = ["google_compute_http_health_check.node-adminrouter-healthcheck"]
}

resource "google_compute_forwarding_rule" "external-node-forwarding-rule-https" {
  name                  = "${var.name_prefix}-${var.dcos_role}-ext-lb-rule-https"
  load_balancing_scheme = "EXTERNAL"
  target                = "${google_compute_target_pool.node-pool.self_link}"
  port_range            = "443"
  ip_address            = "${google_compute_address.node.address}"
  depends_on            = ["google_compute_http_health_check.node-adminrouter-healthcheck"]
}

# Target Pool for external load balancing access
resource "google_compute_target_pool" "node-pool" {
  name = "${var.name_prefix}-${var.dcos_role}-pool"

  instances = ["${var.instances_self_link}"]

  health_checks = [
    "${google_compute_http_health_check.node-adminrouter-healthcheck.name}",
  ]
}

# Used for the external load balancer. The external load balancer only supports google_compute_http_health_check resource.
resource "google_compute_http_health_check" "node-adminrouter-healthcheck" {
  name                = "${var.name_prefix}-ext-http-${var.dcos_role}-check"
  check_interval_sec  = 30
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
  port                = "80"
}
