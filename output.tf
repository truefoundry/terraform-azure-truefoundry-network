####################################################################################
### VPC Output
####################################################################################

output "vnet_id" {
  value = var.shim == true ? var.vnet_id : module.vnet[0].vnet_id
}

output "vnet_address_space" {
  value = var.shim == true ? [] : module.vnet[0].vnet_address_space
}

output "subnet_id" {
  value = var.shim == true ? var.subnet_id : module.vnet[0].vnet_subnets[0]
}
