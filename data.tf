data "azurerm_virtual_network" "vnet" {
  count = var.use_existing_vnet ? 1 : 0
  name                = local.vnet_name
  resource_group_name = var.resource_group_name
}