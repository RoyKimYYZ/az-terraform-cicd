#!/bin/sh

az login --use-device-code # login to azure account
### 
az account list --query "[].{name:name, subscriptionId:id, tenantId:tenantId}" --output table
az account set --subscription="${SUBSCRIPTION_ID}"

echo "Setting environment variables for Terraform"
export ARM_SUBSCRIPTION_ID=d4697920-75d5-4b07-bdbb-ca7abb88444d
export ARM_CLIENT_ID=your_appId
export ARM_CLIENT_SECRET=your_password
export ARM_TENANT_ID=your_tenant_id


terraform init
terraform plan -out out.tfplan
terraform apply out.tfplan
# altenative to run with out terraform plan
terraform apply -var-file="dev.tfvars" -auto-approve

terraform apply -auto-approve
terraform apply
terraform destroy -auto-approve

