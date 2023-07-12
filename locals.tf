locals {
  vnet_name = "${var.cluster_name}-vnet"
  tags = merge(
    {
      "terraform-module" = "network"
      "terraform"        = "true"
      "cluster-name"     = var.cluster_name
    },
    var.tags
  )
}