####################################################################################
### VPC Output
####################################################################################

output "vnet_id" {
  value = var.shim == true ? var.vnet_id : module.vnet[0].vnet_id
}

output "vnet_name" {
  value = local.vnet_name
}
output "vnet_address_space" {
  value = var.shim == true ? [] : module.vnet[0].vnet_address_space
}

output "subnet_id" {
  value = var.shim == true ? var.subnet_id : module.vnet[0].vnet_subnets[0]
}

output "db_private_dns_zone_id" {
  value = var.control_plane_enabled ? azurerm_private_dns_zone.postgres_dns[0].id : ""
}