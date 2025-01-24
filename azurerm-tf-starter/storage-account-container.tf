
module "storage_blob_container" {
  source                = "./modules/storage-blob-container"
  container_name        = var.container_name
  storage_account_name  = azurerm_storage_account.sa.name # Use the storage account name as the container's parent
  storage_account_id    = azurerm_storage_account.sa.id # Use the storage account ID as the container's parent

  depends_on = [ azurerm_storage_account.sa ] # Ensure the storage account is created first
}