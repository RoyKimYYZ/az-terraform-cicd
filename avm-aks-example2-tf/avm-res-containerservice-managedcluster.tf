# The following code is an example of how to use the avm-res-containerservice-managedcluster module
# The module creates an AKS cluster with a default node
# pool and a managed identity. The module also creates a Log Analytics workspace
# and configures the AKS cluster to send diagnostic logs to the workspace.
# The user defined values are passed in as variables
#   resource group name
#   location
#   name
# Specific call outs that the module uses
#   Azure Naming module to generate unique names for the resources.
#   Azure Regions module to randomize the region for the resource group.
#   Azure Client Config module to get the tenant ID for the AKS cluster.
#   Azure Log Analytics Workspace module to create a Log Analytics workspace and referenced throuh the AKS cluster diagnostic settings. This is optional.
 
# You can find this most simple default example code https://github.com/Azure/terraform-azurerm-avm-res-storage-storageaccount/tree/main/examples/default
# I have adapted in a few places to get it working in a simple environment.
# I execute this code logged in with my Azure CLI account.

terraform {
  required_version = ">= 1.9.2" # Terraform Latest Version https://developer.hashicorp.com/terraform/install
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0, < 5.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
    
  subscription_id = var.subscription_id # This is my test azure subscription and is required. Ener your subscription ID here.
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

## Section to provide a random Azure region for the resource group
# This allows us to randomize the region for the resource group.
module "regions" {
  source  = "Azure/avm-utl-regions/azurerm"
  version = "~> 0.1"
}

# This allows us to randomize the region for the resource group.
resource "random_integer" "region_index" {
  max = length(module.regions.regions) - 1
  min = 0
}
## End of section to provide a random Azure region for the resource group

# This ensures we have unique CAF compliant names for our resources.
# https://registry.terraform.io/modules/Azure/naming/azurerm/latest
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "~> 0.3"
  suffix = [var.resource_name_suffix]
}

# This is required for resource modules
resource "azurerm_resource_group" "this" {
  location = var.location
  name     = module.naming.resource_group.name
}

resource "azurerm_log_analytics_workspace" "this" {
  location            = azurerm_resource_group.this.location
  name                = module.naming.log_analytics_workspace.name
  resource_group_name = azurerm_resource_group.this.name
}

data "azurerm_client_config" "current" {}

# This is the avm-res-containerservice-managedcluster module call
# Do not specify location here due to the randomization above.
# Leaving location as `null` will cause the module to use the resource group location
# with a data source.
# https://registry.terraform.io/modules/Azure/avm-res-containerservice-managedcluster/azurerm/latest?tab=inputs
# https://github.com/Azure/terraform-azurerm-avm-res-containerservice-managedcluster
module "avm-res-containerservice-managedcluster" { # avm-res-containerservice-managedcluster
  source              = "Azure/avm-res-containerservice-managedcluster/azurerm" # Replaced to explicit source
  name                = module.naming.kubernetes_cluster.name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  azure_active_directory_role_based_access_control = {
    azure_rbac_enabled = true
    tenant_id          = data.azurerm_client_config.current.tenant_id
  }

  default_node_pool = {
    name       = "default"
    vm_size    = "Standard_DS2_v2"
    node_count = 3

    upgrade_settings = { 
      max_surge = "10%" # This is the maximum number of nodes that can be added during an upgrade
    }
  }
  managed_identities = {
    system_assigned = true 
  }
  diagnostic_settings = {
    to_la = {
      name                  = "to-la"
      workspace_resource_id = azurerm_log_analytics_workspace.this.id
    }
  }
}


module "avm-res-containerregistry-registry" {
  source  = "Azure/avm-res-containerregistry-registry/azurerm"
  version = "0.4.0"
  name     = module.naming.container_registry.name
  location = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  sku = "Premium" # Basic, Standard, Premium
  zone_redundancy_enabled = false # cost effective option
  managed_identities = {
    system_assigned = true
  }

  role_assignments = {
    role_01 = {
      principal_id               = module.avm-res-containerservice-managedcluster.kubelet_identity_id
      role_definition_id_or_name = "AcrPull"
    }
  }

  # role_assignments = {
  #     role_definition_id_or_name = "AcrPull"
  #     principal_id         = module.avm-res-containerservice-managedcluster.kubelet_identity_id
  # }

  diagnostic_settings = {
    to_la = {
      name                  = "to-la"
      workspace_resource_id = azurerm_log_analytics_workspace.this.id
    }
  }
  
}

# resource "azurerm_role_assignment" "acr" {
#   principal_id                     = module.avm-res-containerservice-managedcluster.kubelet_identity_id
#   scope                            = module.avm-res-containerregistry-registry.resource_id
#   role_definition_name             = "AcrPull"
#   skip_service_principal_aad_check = true
# }

output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "location" {
  value = azurerm_resource_group.this.location
}

# output "avm-res-containerservice-managedcluster_name" {
#   value = avm-res-containerservice-managedcluster.name
# }

