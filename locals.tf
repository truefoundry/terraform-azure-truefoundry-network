locals {
  vnet_name = var.use_existing_vnet ? element(split("/", var.vnet_id), length(split("/", var.vnet_id)) - 1) : "${var.cluster_name}-vnet"
  tags = merge(
    {
      "terraform-module" = "terraform-azure-truefoundry-network"
      "terraform"        = "true"
      "cluster-name"     = var.cluster_name
    },
    var.tags
  )
}