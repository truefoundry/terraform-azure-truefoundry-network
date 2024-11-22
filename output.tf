####################################################################################
### VPC Output
####################################################################################

output "vnet_id" {
  value = var.use_existing_vnet ? var.vnet_id : module.vnet[0].vnet_id
}

output "vnet_name" {
  value = local.vnet_name
}
output "vnet_address_space" {
  value = var.use_existing_vnet ? [] : module.vnet[0].vnet_address_space
}

output "subnet_id" {
  value = var.use_existing_vnet ? var.subnet_id : module.vnet[0].vnet_subnets[0]
}

output "db_private_dns_zone_id" {
  value = var.control_plane_enabled ? azurerm_private_dns_zone.postgres_dns[0].id : ""
}

output "vnet_start_ip_address" {
  value = var.use_existing_vnet ? cidrhost(data.azurerm_virtual_network.vnet[0].address_space[0], 0) : cidrhost(var.vnet_cidr, 0)
}

output "vnet_end_ip_address" {
  value = var.use_existing_vnet ? cidrhost(data.azurerm_virtual_network.vnet[0].address_space[0], -1) : cidrhost(var.vnet_cidr, -1)
}