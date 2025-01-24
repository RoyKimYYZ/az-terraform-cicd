# containing the terraform block, provider configurations, and aliases.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" # Azure Provider
      version = ">=4.15.0"          # latest version https://registry.terraform.io/providers/hashicorp/azurerm/latest
    }
  }
  required_version = ">= 1.1.0" #required_version = ">=1.0.0" # Terraform Latest Version https://developer.hashicorp.com/terraform/install

  # terraform state file storage
  # comment out backend block to use local state file
  # to use remote state file, uncomment backend block and create storage account and container and populate the values
  # access to this storage account is through your Azure CLI login
  #backend "azurerm" {
  # resource_group_name = "enterprise" # resource group in which the storage account
  # storage_account_name = "rkimstorage"
  # container_name = "tfstate"
  # key = "terraform.tfstate"
  #}
}
# Azure Providers
provider "azurerm" {
  #   alias = "prod"
  subscription_id = "2dac1c43-b88c-412f-8b6c-89295fe465de"
  #   client_id = ""
  #   client_secret = ""
  #   tenant_id = "12345678"
  features {}
}