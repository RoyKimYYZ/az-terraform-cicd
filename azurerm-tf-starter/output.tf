# Used to define output values that are useful for displaying information about your infrastructure after it has been created or updated. These output values can be used for several purposes:
# Outputs can provide information about the resources created, such as resource names, IDs, or other attributes. This is useful for understanding the state of your infrastructure.

output "resource_group_name" {
  value = azurerm_resource_group.rg.name

}

output "location" {
  value = azurerm_resource_group.rg.location

}

output "azurerm_client_config_current" {
  value = data.azurerm_client_config.current
}

output "random_string_result" {
  value = random_string.random.result
}

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

# output storage_account_container {
#   value = azurerm_storage_container.container.name
# }


