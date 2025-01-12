output "terraform_backend_config" {
  value = {
    resource_group_name  = azapi_resource.rg.name
    storage_account_name = azapi_resource.stg.name
    container_name       = azapi_resource.stg_blob_container.name
  }
}
