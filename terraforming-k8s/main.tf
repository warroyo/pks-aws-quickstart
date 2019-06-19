provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"

  version = "~> 1.60"
}

terraform {
  required_version = "< 0.12.0"
}

locals {
  lb_name = "${var.env_name}-${var.cluster_name}-api"
}

resource "aws_lb" "k8s-api" {
  name                             = "${local.lb}-api"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  internal                         = false
  subnets                          = ["${var.public_subnet_ids}"]
}


resource "aws_lb_listener" "k8s-api_8443" {
  load_balancer_arn = "${aws_lb.k8s-api.arn}"
  port              = 8443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.k8s-api_8443.arn}"
  }
}

resource "aws_lb_target_group" "k8s-api_8443" {
  name     = "${var.env_name}-${var.cluster_name}-tg-8443"
  port     = 8443
  protocol = "TCP"
  vpc_id   = "${var.network}"
}

resource "aws_lb_target_group_attachment" "k8s-api_8443" {
  count            = "${var.instances.count}"
  target_group_arn = "${aws_lb_target_group.k8s-api_8443.arn}"
  target_id        = "${element(var.instances, count.index)}"
  port             = 8443
}


resource "aws_route53_record" "k8s-api_dns" {
  zone_id = "${var.dns_zone_name}"
  name    = "${var.cluster_name}.${var.dns_zone_dns_name}"
  type    = "A"

  alias {
    name                   = "${aws_lb.k8s-api.dns_name}"
    zone_id                = "${aws_lb.k8s-api.zone_id}"
    evaluate_target_health = true
  }

}
