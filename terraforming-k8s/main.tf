provider "google" {
  project     = "${var.project}"
  region      = "${var.region}"
  credentials = "${var.service_account_key}"

  version = "~> 1.20"
}

terraform {
  required_version = "< 0.12.0"
}

locals {
  lb_name = "${var.env_name}-${var.cluster_name}-api"
  target_tags = ["${local.lb_name}", "master"]
}

resource "google_compute_http_health_check" "lb" {
  name                = "${var.env_name}-${var.cluster_name}-health-check"
  port                = 8443
  request_path        = "/health"
  check_interval_sec  = 0
  timeout_sec         = 0
  healthy_threshold   = 0
  unhealthy_threshold = 0

  count = 1
}

resource "google_compute_firewall" "health_check" {
  name    = "${var.env_name}-${var.cluster_name}-health-check"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["8443"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  target_tags = ["${compact(local.target_tags)}"]

  count = 1
}

resource "google_compute_firewall" "lb" {
  name    = "${var.env_name}-${var.cluster_name}-firewall"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["8443"]
  }

  target_tags = ["${compact(local.target_tags)}"]

  count = 1
}

resource "google_compute_address" "lb" {
  name = "${var.env_name}-${var.cluster_name}-address"

  count = 1
}

resource "google_dns_record_set" "cluster-dns" {
  name = "${var.cluster_name}.${var.dns_zone_dns_name}."
  type = "A"
  ttl  = 300

  managed_zone = "${var.dns_zone_name}"

  rrdatas = ["${google_compute_address.lb.address}"]
}

resource "google_compute_forwarding_rule" "lb" {
  name        = "${var.env_name}-${var.cluster_name}-lb"
  ip_address  = "${google_compute_address.lb.address}"
  target      = "${google_compute_target_pool.lb.self_link}"
  port_range  = "8443"
  ip_protocol = "TCP"

  count = 1
}

resource "google_compute_target_pool" "lb" {
  name = "${var.env_name}-${var.cluster_name}-api"

  health_checks = ["${google_compute_http_health_check.lb.*.name}"]
  instances = ["${var.instances}"]
  count = 1
}