variable "resource_group_name" {
  default     = "rk-aks-rg"
  description = "Name of primary resource group"
  type        = string
  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "Resource group name cannot be empty"
  }
  nullable = false
}

variable "location" {
  default = "canadacentral"
  type    = string
  validation {
    condition = contains(["eastus",
      "eastus2",
      "centralus",
      "northcentralus",
      "southcentralus",
      "westus",
      "westus2",
      "westus3",
      "canadacentral",
      "canadaeast",
      "northeurope",
      "westeurope",
      "francecentral",
      "francesouth",
    "uksouth", ], var.location)
    error_message = "Location must be one of the Azure regions"
  }
  nullable    = false
  description = "Preferred Azure regions"
}

# STORAGE ACCOUNT
variable aks_name {
  type       = string
}

variable resource_name_suffix {
  default = "rk"
  type       = string
}