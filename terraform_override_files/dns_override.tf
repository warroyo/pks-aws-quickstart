variable "parent_managed_zone" {
  type = "string"
}

resource "aws_route53_record" "nameserver" {
  name = "${var.env_name}.${var.dns_suffix}"
  type = "NS"
  ttl  = 60

  zone_id = "${var.parent_managed_zone}"

  records = ["${module.infra.name_servers}"]
}

#overriding the infra/dns module since in 0.37 it is broken and adds the NS record as a list.
resource "aws_route53_record" "name_servers" {

  zone_id = "${module.infra.zone_id}"
  name    = "${var.env_name}.${var.dns_suffix}"

  type = "NS"
  ttl  = 300

  records = ["${module.infra.name_servers}"]
}