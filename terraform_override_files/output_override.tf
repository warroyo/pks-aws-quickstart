output "subnet_mgmt_reserved" {
  value     = [
    "${cidrhost(module.infra.ip_cidr_range[0], 1)}-${cidrhost(module.infra.ip_cidr_range[0], 9)}",
    "${cidrhost(module.infra.ip_cidr_range[1], 1)}-${cidrhost(module.infra.ip_cidr_range[1], 9)}",
    "${cidrhost(module.infra.ip_cidr_range[2], 1)}-${cidrhost(module.infra.ip_cidr_range[2], 9)}"
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
    "${cidrhost(module.pks.pks_services_subnet_cidrs[0], 1)}-${cidrhost(module.pks.pks_services_subnet_cidrs[0], 9)}",
    "${cidrhost(module.pks.pks_services_subnet_cidrs[1], 1)}-${cidrhost(module.pks.pks_services_subnet_cidrs[1], 9)}",
    "${cidrhost(module.pks.pks_services_subnet_cidrs[2], 1)}-${cidrhost(module.pks.pks_services_subnet_cidrs[2], 9)}"
  ]
}
