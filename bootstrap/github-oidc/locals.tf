locals {
  environment_secrets = {
    ARM_CLIENT_ID       = azapi_resource.umi.output.properties.clientId
    ARM_TENANT_ID       = azapi_resource.umi.output.properties.tenantId
    ARM_SUBSCRIPTION_ID = var.subscription_id
  }
}
