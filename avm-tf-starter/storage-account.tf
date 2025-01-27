module "avm-res-storage-storageaccount" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.4.0"
  resource_group_name = var.resource_group_name
  location = var.location
  name = var.name
  #shared_access_key_enabled = var.shared_access_key_enabled
  containers = {
    container1 = {
      name = var.container_name,
      public_access = "Container"
    }
  }
  depends_on = [ azurerm_resource_group.rg ]
}