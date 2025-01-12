resource "azapi_resource" "rg" {
  type      = "Microsoft.Resources/resourceGroups@2024-07-01"
  name      = "rg-${local.pseudo_random_resource_suffix}"
  location  = "uksouth"
  parent_id = "/subscriptions/${var.subscription_id}"
}

resource "azapi_resource" "role_assignment_umi_rg" {
  type      = "Microsoft.Authorization/roleAssignments@2022-04-01"
  parent_id = azapi_resource.rg.id
  name      = uuidv5("url", join("", [azapi_resource.umi.id, azapi_resource.rg.id, "8e3af657-a8ff-443c-a75c-2fe8c4bcb635"]))
  body = {
    properties = {
      principalId      = azapi_resource.umi.output.properties.principalId
      roleDefinitionId = provider::azapi::subscription_resource_id(var.subscription_id, "Microsoft.Authorization/roleDefinitions", ["8e3af657-a8ff-443c-a75c-2fe8c4bcb635"]) # Owner
      principalType    = "ServicePrincipal"
    }
  }
}
