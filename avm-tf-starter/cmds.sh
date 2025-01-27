
az login --use-device-code

az account list --output table
az account set --subscription "Visual Studio Enterprise" #"2dac1c43-b88c-412f-8b6c-89295fe465de"
az account show -o table

terraform init #-backend-config="storage_account_name=<YourAzureStorageAccountName>" -backend-config="container_name=tfstate" -backend-config="access_key=<YourStorageAccountAccessKey>" -backend-config="key=codelab.microsoft.tfstate"
terraform plan -var-file="dev.tfvars" -out out.plan
terraform apply out.plan
# altenative to the above 2 commands
terraform apply -var-file="dev.tfvars"

terraform destroy -auto-approve -var-file="dev.tfvars"

terraform fmt # Format your configuration. Terraform will print out the names of the files it modified, if any.
terraform show # Show the current state of your infrastructure. This will output the current state of your infrastructure in a human-readable format.

terraform plan   -var-file="dev.tfvars" -out out.plan 