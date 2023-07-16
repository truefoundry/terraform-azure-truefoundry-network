#############################################################################
# RESOURCES
#############################################################################

# resource "azurerm_virtual_network" "network" {
#   count               = var.shim == true ? 0 : 1
#   name                = local.vnet_name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   address_space       = [var.vnet_cidr]
#   subnet {
#     name           = substr("${local.vnet_name}-subnet1", 0, 80)
#     address_prefix = var.subnet_cidr
#   }
#   tags = local.tags
# }

module "vnet" {
  count   = var.shim == true ? 0 : 1
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"

  resource_group_name = var.resource_group_name
  use_for_each = var.use_for_each
  vnet_location = var.location
  address_space = [var.vnet_cidr]
  vnet_name = local.vnet_name
  subnet_prefixes = [var.subnet_cidr]
  subnet_names = [substr("${local.vnet_name}-subnet", 0, 80)]
  tags = local.tags
}