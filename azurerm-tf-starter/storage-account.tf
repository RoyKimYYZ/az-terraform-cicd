# https://registry.terraform.io/modules/Azure/avm-res-storage-storageaccount/azurerm/latest?tab=inputs

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "sa" {
  name                     = (var.storage_account_name == null ? random_string.random.result : var.storage_account_name)
  resource_group_name      = azurerm_resource_group.rg.name # Alternative "${azurerm_resource_group.rg.name}-${random_string.random.result}"
  location                 = var.location
  account_kind             = var.account_kind
  account_tier             = local.account_tier
  account_replication_type = var.replication_type
  access_tier              = var.access_tier
  tags                     = var.tags
  is_hns_enabled                    = var.enable_hns # hierarchical namespace feature for Azure Data Lake Storage Gen2. When this feature is enabled, it allows the storage account to support directory and file-level access control lists (ACLs), which is essential for big data analytics workloads.
  sftp_enabled                      = var.enable_sftp
  large_file_share_enabled          = var.enable_large_file_share
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  https_traffic_only_enabled        = var.https_traffic_only_enabled
  min_tls_version                   = var.min_tls_version
  nfsv3_enabled                     = var.nfsv3_enabled
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  shared_access_key_enabled         = var.shared_access_key_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  default_to_oauth_authentication   = var.default_to_oauth_authentication
  allowed_copy_scope                = var.allowed_copy_scope
  identity {
    type = "SystemAssigned"
  }

}
## azure reference https://docs.microsoft.com/en-us/azure/storage/common/infrastructure-encryption-enable?tabs=portal
resource "azurerm_storage_encryption_scope" "scope" {
  for_each = var.encryption_scopes

  name                               = each.key
  storage_account_id                 = azurerm_storage_account.sa.id
  source                             = coalesce(each.value.source, "Microsoft.Storage")
  infrastructure_encryption_required = coalesce(each.value.enable_infrastructure_encryption, var.infrastructure_encryption_enabled)
}