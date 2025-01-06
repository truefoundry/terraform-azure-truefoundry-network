data "azurerm_virtual_network" "vnet" {
  count               = var.use_existing_vnet ? 1 : 0
  name                = local.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "subnet" {
  depends_on = [
    data.azurerm_virtual_network.vnet
  ]
  count                = var.use_existing_vnet ? 1 : 0
  name                 = data.azurerm_virtual_network.vnet[0].subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = local.vnet_name
}
