##################################################################################
## Variables
##################################################################################
variable "shim" {
  description = "If true will not create the network and forward the input values to the same outputs."
  type        = bool
  default     = false
}
### Shim

variable "vnet_id" {
  description = "SHIM: VPC Id"
  type        = string
}
variable "subnet_id" {
  description = "SHIM: Subnet ID"
  type        = string
}

### Non shim
variable "vnet_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "subnet_cidr" {
  description = "Assigns IPv4 subnet"
  type        = string
}

variable "use_for_each" {
  description = "Use `for_each` instead of `count` to create multiple resource instances."
  default = false
  type = bool
}

variable "resource_group_name" {
  description = "Azure Resource Group"
  type        = string
}

variable "cluster_name" {
  description = "AWS EKS cluster name needed for Shared cluster"
  type        = string
}

variable "location" {
  description = "Vnet region"
  type        = string
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "AWS Tags common to all the resources created"
}