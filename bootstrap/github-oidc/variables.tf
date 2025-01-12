variable "repository_name" {
  type        = string
  description = "The name of the GitHub repository to create."
  nullable    = false
}

variable "subscription_id" {
  type        = string
  description = "value of the subscription id"
  nullable    = false

  validation {
    error_message = "The subscription id must be a valid lowercase GUID"
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.subscription_id))
  }
}

variable "tenant_id" {
  type        = string
  description = "value of the Azure tenant id"
  nullable    = false

  validation {
    error_message = "The tenant id must be a valid lowercase GUID"
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.tenant_id))
  }
}

variable "location" {
  type        = string
  description = "The location of the resources to create."
  nullable    = false
}

variable "bootstrap_current_user_has_storage_data_plane_access" {
  type        = bool
  description = <<DESCRIPTION
Whether the current user has access to the storage account data plane.
This is used to migrate the terraform state to the new storage account.
DESCRIPTION
  nullable    = false
}
