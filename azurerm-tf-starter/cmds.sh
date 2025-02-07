
az login --use-device-code


az account list --output table
az account set --subscription "Visual Studio Enterprise"
az account show -o table


terraform init #-backend-config="storage_account_name=<YourAzureStorageAccountName>" -backend-config="container_name=tfstate" -backend-config="access_key=<YourStorageAccountAccessKey>" -backend-config="key=codelab.microsoft.tfstate"
# Note: rerun when you change the backend configuration. E.g. in provider.tf

# To check the syntax and validity of the configuration files in your Terraform project. It ensures that the configuration is syntactically correct and internally consistent, but it does not check whether the configuration will successfully apply against real infrastructure.
terraform validate 
# To create an execution plan. Terraform performs a refresh, unless explicitly disabled, and then determines what actions are necessary to achieve the desired state specified in the configuration files.
terraform plan -var-file="dev.tfvars" -out out.plan
# To apply the changes required to reach the desired state of the configuration.
terraform apply out.plan
# Alternative to the above. 
# To create an execution plan. Terraform performs a refresh, unless explicitly disabled, and then determines what actions are necessary to achieve the desired state specified in the configuration files.
terraform apply -var-file="dev.tfvars" -auto-approve

terraform show # Show the current state of your infrastructure. This will output the current state of your infrastructure in a human-readable format.

# To destroy the Terraform-managed infrastructure.
# provide var file so that you don't have to be prompted for certain values
terraform destroy -var-file="dev.tfvars" -auto-approve  
terraform destroy

terraform fmt # Format your configuration. Terraform will print out the names of the files it modified, if any.
terraform show # Show the current state of your infrastructure. This will output the current state of your infrastructure in a human-readable format.
