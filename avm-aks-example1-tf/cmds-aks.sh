#!/bin/sh

az login --use-device-code # login to azure account
### 
az account list --query "[].{name:name, subscriptionId:id, tenantId:tenantId}" --output table
az account set --subscription="${SUBSCRIPTION_ID}"


terraform init
terraform plan -out out.tfplan
terraform apply out.tfplan
# altenative to run with out terraform plan
terraform apply -var-file="dev1.tfvars" -auto-approve

terraform apply -auto-approve
terraform apply
terraform destroy -auto-approve

