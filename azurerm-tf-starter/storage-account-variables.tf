# https://github.com/Azure-Terraform/terraform-azurerm-storage-account/blob/main/variables.tf

variable "storage_account_name" {
  default     = "rkimstorage"
  description = "Name of the storage account"
  type        = string
  validation {
    condition     = length(var.storage_account_name) > 0
    error_message = "Storage account name cannot be empty"
  }
  nullable = false
}

# variable "location" {
#   description = "Specifies the supported Azure location to storage account"
#   type        = string
# }

# variable "resource_group_name" {
#   description = "Name of the resource group to create the resource"
#   type        = string
# }

variable "tags" {
  description = "tags to be applied to resources"
  type        = map(string)
  default = {
    "env"        = "dev",
    "costcenter" = "123"
  }
}

variable "account_kind" {
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2"
  type        = string
  validation {
    condition     = (contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.account_kind))
    error_message = "The account_kind must be either \"BlobStorage\", \"BlockBlobStorage\", \"FileStorage\", \"Storage\" or \"StorageV2\"."
  }
  default = "StorageV2"
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account (Standard or Premium)."
  type        = string
  default     = null
}

variable "access_tier" {
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts"
  type        = string
  default     = "Hot"

  validation {
    condition     = (contains(["hot", "cool"], lower(var.access_tier)))
    error_message = "The account_tier must be either \"Hot\" or \"Cool\"."
  }
}

variable "blob_last_access_time_enabled" {
  description = "Controls whether blob last access time recording is enabled for container usage."
  type        = bool
  default     = false
}

variable "replication_type" {
  description = "Storage account replication type - i.e. LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS."
  type        = string
  default     = "LRS"
}

variable "enable_large_file_share" {
  description = "Enable Large File Share."
  type        = bool
  default     = false
}

variable "enable_hns" {
  description = "Enable Hierarchical Namespace (can be used with Azure Data Lake Storage Gen 2)."
  type        = bool
  default     = false
}

variable "enable_sftp" {
  description = "Enable SFTP for storage account (enable_hns must be set to true for this to work)."
  type        = bool
  default     = false
}

variable "https_traffic_only_enabled" {
  description = "Forces HTTPS if enabled."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Allow or disallow public access to all blobs or containers in the storage account. The default interpretation is true for this property."
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account."
  type        = string
  default     = "TLS1_2"
}

# Note: if false, make sure to include the IP address of the host from where "terraform" command is executed to allow for access to the storage, otherwise, creating container inside the storage or any access attempt will be denied.
variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow public access to all blobs or containers in the storage account."
  type        = bool
  default     = true
}

# Note: make sure to include the IP address of the host from where "terraform" command is executed to allow for access to the storage
# Otherwise, creating container inside the storage or any access attempt will be denied.
variable "access_list" {
  description = "Map of CIDRs Storage Account access."
  type        = map(string)
  default     = {}
}

variable "service_endpoints" {
  description = "Creates a virtual network rule in the subnet_id (values are virtual network subnet ids)."
  type        = map(string)
  default     = {}
}

variable "traffic_bypass" {
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None."
  type        = list(string)
  default     = ["AzureServices"] // https://docs.bridgecrew.io/docs/enable-trusted-microsoft-services-for-storage-account-access
}

variable "blob_delete_retention_days" {
  description = "Retention days for deleted blob. Valid value is between 1 and 365 (set to 0 to disable)."
  type        = number
  default     = 7
}

variable "blob_cors" {
  description = "blob service cors rules:  https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#cors_rule"
  type = map(object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))
  default = null
}

variable "enable_static_website" {
  description = "Controls if static website to be enabled on the storage account. Possible values are `true` or `false`"
  type        = bool
  default     = false
}

variable "cross_tenant_replication_enabled" {
  description = "Enable cross tenant replication when needed and valid reason. Possible values are `true` or `false`"
  type        = bool
  default     = false
}

variable "index_path" {
  description = "path from your repo root to index.html"
  type        = string
  default     = null
}

variable "custom_404_path" {
  description = "path from your repo root to your custom 404 page"
  type        = string
  default     = null
}

variable "encryption_scopes" {
  description = "Encryption scopes, keys are scope names. more info https://docs.microsoft.com/en-us/azure/storage/common/infrastructure-encryption-enable?tabs=portal"
  type = map(object({
    enable_infrastructure_encryption = optional(bool)
    source                           = optional(string)
  }))

  default = {}
}

variable "infrastructure_encryption_enabled" {
  description = "Is infrastructure encryption enabled? Changing this forces a new resource to be created."
  type        = bool
  default     = true
}

variable "nfsv3_enabled" {
  description = "Is NFSv3 protocol enabled? Changing this forces a new resource to be created"
  type        = bool
  default     = false
}

variable "default_network_rule" {
  description = "Specifies the default action of allow or deny when no other network rules match"
  type        = string
  default     = "Deny"

  validation {
    condition     = (contains(["deny", "allow"], lower(var.default_network_rule)))
    error_message = "The default_network_rule must be either \"Deny\" or \"Allow\"."
  }
}

variable "shared_access_key_enabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key"
  type        = bool
  default     = false
}

variable "default_to_oauth_authentication" {
  description = "Set default authentication to storage account content"
  type        = bool
  default     = false
}

variable "blob_versioning_enabled" {
  description = "Controls whether blob object versioning is enabled."
  type        = bool
  default     = false
}

variable "container_delete_retention_days" {
  description = "Retention days for deleted container. Valid value is between 1 and 365 (set to 0 to disable)."
  type        = number
  default     = 7
}

variable "allowed_copy_scope" {
  description = "Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink."
  type        = string
  default     = null
}