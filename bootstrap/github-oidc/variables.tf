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
    error_message = "The tenaant id must be a valid lowercase GUID"
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.subscription_id))
  }
}

variable "location" {
  type        = string
  description = "The location of the resources to create."
  nullable    = false
}
