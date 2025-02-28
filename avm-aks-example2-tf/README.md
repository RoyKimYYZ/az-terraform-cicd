This IAC deployment scenario is centered aroudn The Azure Verified Modules(AVM) for AKS. 


Given a resource group, an Azure Kubernetes Cluster is deployed. Azure Container Registry(ACR) so that AKS can pull docker images for any application that may be deployed into the AKS cluster. The role assignment to the container registry uses the ACR Pull role.

![aks-law-acr-diagram](aks-law-acr-tf.png)

## Azure Portal Deployment

Resource Group
![alt text](aks-law-acr-rg-portal.png)

