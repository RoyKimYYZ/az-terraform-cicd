This IAC deployment scenario is to demonstrate The Azure Verified Modules (AVM) for [Azure Kubernetes Service](https://registry.terraform.io/modules/Azure/avm-res-containerservice-managedcluster/azurerm/latest), [Log Analytics Workspace](https://registry.terraform.io/modules/Azure/avm-res-operationalinsights-workspace/azurerm/latest) and [Azure Container Registry](https://registry.terraform.io/modules/Azure/avm-res-containerregistry-registry/azurerm/latest).


* Given a resource group, an Azure Kubernetes Cluster is deployed.
* The Azure Container Registry (ACR) is used so that AKS can pull docker images of applications and may be deployed into the AKS cluster. 
  * The role assignment from the AKS cluster to the container registry uses the ACR Pull role.
* A Log Analytics workspace is used to collect metrics and logs from both the AKS resource and Azure Container resource. The diagnostic settings of each resource is configured to refernce the log analytics workspace

The terraform code is taken from https://registry.terraform.io/modules/Azure/avm-res-containerservice-managedcluster/azurerm/latest/examples/default

<img src='aks-law-acr-tf.png' style='width:100%;max-width:500px;'>

## Azure Portal Deployment

Resource Group
![alt text](aks-law-acr-rg-portal.png)

Azure Kubernetes Service - Diagnostic Settings
![alt text](aks-law-diag-portal.png)

Azure Container Registry - Diagnostic Settings
![alt text](acr-diag-portal.png)


Find Terraform AVM Resource Modules [here](https://azure.github.io/Azure-Verified-Modules/indexes/terraform/tf-resource-modules/)