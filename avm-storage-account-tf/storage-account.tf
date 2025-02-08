module "avm-res-storage-storageaccount" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.4.0"
  resource_group_name = var.resource_group_name
  location = var.location
  name = "${var.storage_account_name}${random_string.random_name.id}"
  public_network_access_enabled = true # this also enables access to blob containers from the internet
  shared_access_key_enabled = var.shared_access_key_enabled # NOTE: This is required for the storage account to be accessible from the internet. Otherwise error: KeyBasedAuthenticationNotPermitted: Key based authentication is not permitted on this storage account.
  # Otherwise error: Storage Account Name: "rkimstorageavm") to become available: waiting for the Blob Service to become available: polling failed: executing request: unexpected status 403 (403 Key based authentication is not permitted on this storage account.) with KeyBasedAuthenticationNotPermitted: Key based authentication is not permitted on this storage account.
  containers = {
    container1 = {
      name = var.container_name
    }
  }
  depends_on = [ azurerm_resource_group.rg ]
}
