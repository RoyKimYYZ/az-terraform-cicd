// filepath: terraform-modules/storage-blob-container/main.tf
resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_id    = var.storage_account_id
  container_access_type = var.container_access_type
}