variable "parent_managed_zone" {
  type = "string"
}

resource "aws_route53_record" "nameserver" {
  name = "${var.env_name}.${var.dns_suffix}."
  type = "NS"
  ttl  = 300

  zone_id = "${var.parent_managed_zone}"

  rrdatas = ["${module.infra.name_servers}"]
}