# main.tf purpose is to deploy to define resource group and any simple utilities.

# The azurerm_client_config data source retrieves information about the current Azure CLI or Service Principal authentication context.
# This is useful for obtaining details about the authenticated user or service principal, such as the tenant ID, subscription ID, and client ID.
data "azurerm_client_config" "current" {}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# utility or helper random string to use for any resource name suffix for uniqueness.
resource "random_string" "random_name" {
  length  = 3
  special = false
  upper   = false
}

# utility or helper random pet name to use for any resource name suffix for uniqueness.
resource "random_pet" "name" {
  length    = 3
  # separator = "-"

}
