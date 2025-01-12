resource "random_id" "stg" {
  byte_length = 6
  prefix      = "stg"
}

resource "azapi_resource" "stg" {
  type      = "Microsoft.Storage/storageAccounts@2023-05-01"
  name      = random_id.stg.hex
  parent_id = azapi_resource.rg.id
  location  = azapi_resource.rg.location
  body = {
    properties = {
      accessTier                   = "Hot"
      allowSharedKeyAccess         = false
      supportsHttpsTrafficOnly     = true
      isSftpEnabled                = false
      minimumTlsVersion            = "TLS1_2"
      isHnsEnabled                 = false
      defaultToOAuthAuthentication = true
    }
    kind = "StorageV2"
    sku = {
      name = "Standard_LRS"
    }
  }
}

resource "azapi_resource" "stg_blob_container" {
  type      = "Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01"
  parent_id = "${azapi_resource.stg.id}/blobServices/default"
  name      = "tfstate"
}
