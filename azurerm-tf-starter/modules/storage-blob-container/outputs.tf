// filepath: terraform-modules/storage-blob-container/outputs.tf
output "container_id" {
  value = azurerm_storage_container.container.id
}

output "container_name" {
  value = azurerm_storage_container.container.name
}