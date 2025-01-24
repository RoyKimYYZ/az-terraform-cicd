// filepath: /home/rkadmin/terraform/az-tf-starter/variables.tf
variable "container_name" {
  description = "The name of the storage container"
  type        = string
  default     = "example-container"
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "storage_account_id" {
  description = "The name of the storage account"
  type        = string
}

variable "container_access_type" {
  description = "The access type of the storage container"
  type        = string
  default     = "private"
    validation {
        condition     = (contains(["private", "blob", "container"], var.container_access_type))
        error_message = "The container_access_type must be either \"private\", \"blob\" or \"container\"."
    }
}