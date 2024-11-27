locals {
  vnet_name = var.use_existing_vnet ? element(split("/", var.vnet_id), length(split("/", var.vnet_id)) - 1) : "${var.cluster_name}-vnet"
  subnet_name = substr("${local.vnet_name}-subnet", 0, 80)
  tags = merge(
    {
      "terraform-module" = "terraform-azure-truefoundry-network"
      "terraform"        = "true"
      "cluster-name"     = var.cluster_name
    },
    var.tags
  )
}