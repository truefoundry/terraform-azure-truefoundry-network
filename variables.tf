##################################################################################
## Existing network
##################################################################################
variable "use_existing_vnet" {
  description = "Flag to enable existing network"
  type        = bool
  default     = false
}
variable "vnet_id" {
  description = "VPC ID. Used only when use_existing_vnet is enabled"
  type        = string
  validation {
    condition     = var.vnet_id == "" || var.use_existing_vnet
    error_message = "Vnet ID can't be empty if use_existing_vnet is enabled"
  }
}
variable "subnet_id" {
  description = "Subnet ID. Used only when use_existing_vnet is enabled"
  type        = string
  validation {
    condition     = var.subnet_id == "" || var.use_existing_vnet
    error_message = "Subnet ID can't be empty if use_existing_vnet is enabled"
  }
}

##################################################################################
## New network
##################################################################################
variable "vnet_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "subnet_cidr" {
  description = "Assigns IPv4 subnet"
  type        = string
}

variable "control_plane_enabled" {
  description = "Flag to check Control plane enabled"
  type        = bool
}

variable "use_for_each" {
  description = "Use `for_each` instead of `count` to create multiple resource instances."
  default     = false
  type        = bool
}

##################################################################################
## Common
##################################################################################
variable "resource_group_name" {
  description = "Azure Resource Group"
  type        = string
}

variable "cluster_name" {
  description = "Cluster name to generate the virtual network name"
  type        = string
}

variable "location" {
  description = "Location to create the vnet"
  type        = string
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "AWS Tags common to all the resources created"
}