variable "instances" {
    default = ""
}
variable "env_name" {}

variable "access_key" {}
variable "secret_key" {}

variable "region" {}
variable "cluster_name" {}
variable "network" {}
variable "dns_zone_name" {}
variable "dns_zone_dns_name" {}

variable "public_subnet_ids" {
    type = "list"
}
variable "zones" {
    type = "list"
}

variable "security_groups" {
    type = "list"
}