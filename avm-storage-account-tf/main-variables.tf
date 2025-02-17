variable "resource_group_name" {
  default     = "rk-rg"
  description = "Name of primary resource group"
  type        = string
  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "Resource group name cannot be empty"
  }
  nullable = false
}

variable "location" {
  default = "eastus2"
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
  description = "Azure regions"
}


# STORAGE ACCOUNT
variable storage_account_name {
  type       = string
}

variable container_name {
  default = "blobcontainer1"
  type    = string
}

variable shared_access_key_enabled {
  default = false
  type    = bool
}

variable public_network_access_enabled {
  default = false
  type    = bool
}

variable network_rules {
  default = {}
  type = object({
    bypass                     = optional(set(string), ["AzureServices"])
    default_action             = optional(string, "Deny") # Specifies the default action of allow or deny when no other rules match. Valid options are `Deny` or `Allow`.
    ip_rules                   = optional(set(string), [])
    virtual_network_subnet_ids = optional(set(string), [])
    private_link_access = optional(list(object({
      endpoint_resource_id = string
      endpoint_tenant_id   = optional(string)
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  })
}


variable "client_id" {
  default = ""
}
variable "client_secret" {
  default = ""
}

