resource_group_name = "rkrm-rg"
location            = "eastus2"


storage_account_name = "rkimstoragerm"
# public_network_access_enabled = true
shared_access_key_enabled = true # This is required for the storage account to be accessible from the internet. 
# Otherwise error: KeyBasedAuthenticationNotPermitted: Key based authentication is not permitted on this storage account.
container_name = "rkcontainer"