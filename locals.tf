locals {
  vnet_name = var.shim ? var.shim_vnet_name : "${var.cluster_name}-vnet"
  tags = merge(
    {
      "terraform-module" = "terraform-azure-truefoundry-network"
      "terraform"        = "true"
      "cluster-name"     = var.cluster_name
    },
    var.tags
  )
}