#############################################################################
# RESOURCES
#############################################################################

resource "azurerm_virtual_network" "network" {
  count = var.shim == true ? 0 : 1
  name = var.cluster_name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space      = [var.vnet_cidr]
  subnet {
    name = "subnet1"
    address_prefix = var.subnet_cidr
  }
  tags = local.tags
}