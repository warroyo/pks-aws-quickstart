output "subnet_mgmt_reserved" {
  value     = [
    "${cidrhost(module.infra.infrastructure_subnet_cidrs[0], 1)}-${cidrhost(module.infra.infrastructure_subnet_cidrs[0], 9)}",
    "${cidrhost(module.infra.infrastructure_subnet_cidrs[1], 1)}-${cidrhost(module.infra.infrastructure_subnet_cidrs[1], 9)}",
    "${cidrhost(module.infra.infrastructure_subnet_cidrs[2], 1)}-${cidrhost(module.infra.infrastructure_subnet_cidrs[2], 9)}"
  ]
}

output "subnet_pks_reserved" {
  value     = [
    "${cidrhost(module.pks.pks_subnet_cidrs[0], 1)}-${cidrhost(module.pks.pks_subnet_cidrs[0], 9)}",
    "${cidrhost(module.pks.pks_subnet_cidrs[1], 1)}-${cidrhost(module.pks.pks_subnet_cidrs[1], 9)}",
    "${cidrhost(module.pks.pks_subnet_cidrs[2], 1)}-${cidrhost(module.pks.pks_subnet_cidrs[2], 9)}"
  ]
}

output "subnet_pks_svc_reserved" {
  value     = [
    "${cidrhost(module.pks.services_subnet_cidrs[0], 1)}-${cidrhost(module.pks.services_subnet_cidrs[0], 9)}",
    "${cidrhost(module.pks.services_subnet_cidrs[1], 1)}-${cidrhost(module.pks.services_subnet_cidrs[1], 9)}",
    "${cidrhost(module.pks.services_subnet_cidrs[2], 1)}-${cidrhost(module.pks.services_subnet_cidrs[2], 9)}"
  ]
}

output "dns" {
  value = "${cidrhost(var.vpc_cidr, 2)}"
}

output "env_name" {
  value = "${var.env_name}"
}
