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
  subnet_names        = [local.subnet_name]
  tags                = local.tags
  subnet_service_endpoints = {
    # tflint-ignore: terraform_deprecated_interpolation
    "${local.subnet_name}" = ["Microsoft.Storage"]
  }
}

// Custom NAT gateway
resource "azurerm_public_ip" "nat_ip" {
  count               = var.use_default_nat ? 0 : var.use_external_public_addresses ? 0 : 1
  name                = "${var.cluster_name}-nat-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  tags                = var.tags
  sku                 = var.public_ip_address_sku
}

resource "azurerm_nat_gateway" "nat_gateway" {
  count               = var.use_default_nat ? 0 : 1
  name                = "${var.cluster_name}-nat-gw"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_public_ip_association" {
  count                = var.use_default_nat ? 0 : 1
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway[0].id
  public_ip_address_id = var.use_external_public_addresses ? var.external_public_address_id : azurerm_public_ip.nat_ip[0].id
}

resource "azurerm_subnet_nat_gateway_association" "nat_gateway_association" {
  count          = var.use_default_nat ? 0 : 1
  subnet_id      = var.use_existing_vnet ? var.subnet_id : module.vnet[0].vnet_subnets[0]
  nat_gateway_id = azurerm_nat_gateway.nat_gateway[0].id
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