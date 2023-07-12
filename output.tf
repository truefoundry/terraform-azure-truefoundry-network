####################################################################################
### VPC Output
####################################################################################

output "vnet_id" {
  value = var.shim == true ? var.vnet_id : azurerm_virtual_network.network[0].id
}

output "subnet_id" {
  value = var.shim == true ? var.subnet_id : tolist(azurerm_virtual_network.network[0].subnet)[0].id
}
