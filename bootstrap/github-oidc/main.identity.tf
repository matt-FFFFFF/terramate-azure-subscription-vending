resource "random_id" "umi" {
  byte_length = 6
  prefix      = "umi-"
}

resource "azapi_resource" "umi" {
  type      = "Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview"
  name      = random_id.umi.hex
  parent_id = azapi_resource.rg.id
  location  = azapi_resource.rg.location
  body      = {}
  response_export_values = [
    "properties.principalId",
    "properties.clientId",
    "properties.tenantId"
  ]
}

resource "azapi_resource" "umi_federated_credential" {
  type      = "Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2023-07-31-preview"
  parent_id = azapi_resource.umi.id
  name      = "github-oidc"
  locks     = [azapi_resource.umi.id]
  body = {
    properties = {
      audiences = ["api://AzureADTokenExchange"]
      issuer    = "https://token.actions.githubusercontent.com"
      subject   = "repo:matt-FFFFFF/tm-test:environment:prod" # TODO: fix this when adding GH provider
    }
  }
}

resource "azapi_resource" "role_assignment_umi_stg" {
  type      = "Microsoft.Authorization/roleAssignments@2022-04-01"
  parent_id = azapi_resource.stg_blob_container.id
  name      = uuidv5("url", join("", [azapi_resource.umi_federated_credential.id, azapi_resource.stg_blob_container.id, "b7e6dc6d-f1e8-4753-8033-0f276bb0955b"]))
  body = {
    properties = {
      principalId      = azapi_resource.umi.output.properties.principalId
      roleDefinitionId = provider::azapi::subscription_resource_id(var.subscription_id, "Microsoft.Authorization/roleDefinitions", ["b7e6dc6d-f1e8-4753-8033-0f276bb0955b"]) # Storage Blob Data Owner
      principalType    = "ServicePrincipal"
    }
  }
}
