#############################################################################
# RESOURCES
#############################################################################
module "vnet" {
  count   = var.use_existing_vnet ? 0 : 1
  source  = "Azure/vnet/azurerm"
  version = "4.1.0"

  resource_group_name = var.resource_group_name
  use_for_each        = var.use_for_each
  vnet_location       = var.location
  address_space       = [var.vnet_cidr]
  vnet_name           = local.vnet_name
  subnet_prefixes     = [var.subnet_cidr]
  subnet_names        = [substr("${local.vnet_name}-subnet", 0, 80)]
  tags                = local.tags
}

// creating a private dns zone
resource "azurerm_private_dns_zone" "postgres_dns" {
  count               = var.control_plane_enabled ? 1 : 0
  name                = "${replace(local.vnet_name, "-", "")}.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgres_dns_link" {
  count                 = var.control_plane_enabled ? 1 : 0
  name                  = "${replace(local.vnet_name, "-", "")}VnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.postgres_dns[0].name
  virtual_network_id    = var.use_existing_vnet ? var.vnet_id : module.vnet[0].vnet_id
  resource_group_name   = var.resource_group_name
}