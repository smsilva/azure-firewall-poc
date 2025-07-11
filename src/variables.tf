variable "location" {
  type        = string
  description = "Location for all resources."
  default     = "eastus"
}

variable "resource_group_name" {
  type    = string
  default = "wasp-cloud-poc"
}

variable "firewall_sku_tier" {
  type        = string
  description = "Firewall SKU."
  default     = "Standard" # Valid values are Standard and Premium
  validation {
    condition     = contains(["Standard", "Premium"], var.firewall_sku_tier)
    error_message = "The SKU must be one of the following: Standard, Premium"
  }
}

variable "virtual_machine_size" {
  type        = string
  description = "Size of the virtual machine."
  default     = "Standard_D2_v3"
}

variable "virtual_machine_password" {
  type      = string
  sensitive = true
}

variable "admin_username" {
  type        = string
  description = "Value of the admin username."
  default     = "azureuser"
}

variable "cosmos_mongodb_spoke_1_enabled" {
  type        = bool
  description = "Enable Cosmos DB MongoDB account in spoke 1."
  default     = false
}
