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

resource "aws_elb" "k8s-api" {
  name               = "${local.lb_name}"
  availability_zones = ["${var.zones}"]
  security_groups = ["${var.security_groups}"]
  subnets = ["${var.public_subnet_ids}"]

  listener {
    instance_port     = 8443
    instance_protocol = "tcp"
    lb_port           = 8443
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8443"
    interval            = 30
  }

  instances                   = ["${aws_instance.foo.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "${local.lb_name}-elb"
  }
}




resource "aws_route53_record" "k8s-api_dns" {
  zone_id = "${var.dns_zone_name}"
  name    = "${var.cluster_name}.${var.dns_zone_dns_name}"
  type    = "A"

  alias {
    name                   = "${aws_elb.k8s-api.dns_name}"
    zone_id                = "${aws_elb.k8s-api.zone_id}"
    evaluate_target_health = true
  }

}
