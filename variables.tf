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

variable "use_default_nat" {
  description = "Flag to use default NAT gateway. If false, a NAT gateway will be created and associated with the subnet."
  type        = bool
  default     = true
}

variable "use_external_public_addresses" {
  description = "Flag to use external public addresses. If true, var.external_public_addresses will be used for the public IP addresses of the NAT gateway. Only used if var.use_default_nat is false."
  type        = bool
  default     = false
}

variable "external_public_address_id" {
  description = "External public address ID. If empty, a public IP will be created and associated with the NAT gateway. Only used if var.use_default_nat is false and var.use_external_public_addresses is true."
  type        = string
  default     = ""
}

variable "public_ip_address_sku" {
  description = "SKU of the public IP address. Only used if var.use_default_nat is false and var.use_external_public_addresses is false."
  type        = string
  default     = "Standard"
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