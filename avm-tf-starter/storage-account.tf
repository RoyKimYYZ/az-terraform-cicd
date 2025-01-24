module "avm-res-storage-storageaccount" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "0.4.0"
  resource_group_name = var.resource_group_name
  location = var.location
  name = var.name
  public_network_access_enabled = true
  shared_access_key_enabled = true
  allow_nested_items_to_be_public = true
  network_rules = {
    default_action = "Allow" 
  }
  depends_on = [ azurerm_resource_group.rg ]
}