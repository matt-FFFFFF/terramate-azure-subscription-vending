data "azapi_client_config" "bootstrap" {
  count = var.bootstrap_current_user_has_storage_data_plane_access ? 1 : 0
}

resource "azapi_resource" "role_assignment_bootstrap_stg" {
  count     = var.bootstrap_current_user_has_storage_data_plane_access ? 1 : 0
  type      = "Microsoft.Authorization/roleAssignments@2022-04-01"
  parent_id = azapi_resource.stg_blob_container.id
  name      = uuidv5("url", join("", [one(data.azapi_client_config.bootstrap).object_id, azapi_resource.stg_blob_container.id, "b7e6dc6d-f1e8-4753-8033-0f276bb0955b"]))
  body = {
    properties = {
      principalId      = one(data.azapi_client_config.bootstrap).object_id
      roleDefinitionId = provider::azapi::subscription_resource_id(var.subscription_id, "Microsoft.Authorization/roleDefinitions", ["b7e6dc6d-f1e8-4753-8033-0f276bb0955b"]) # Storage Blob Data Owner
    }
  }
}
