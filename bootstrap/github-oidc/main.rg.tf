resource "random_id" "rg" {
  byte_length = 6
  prefix      = "rg-"
}

resource "azapi_resource" "rg" {
  type      = "Microsoft.Resources/resourceGroups@2024-07-01"
  name      = random_id.rg.hex
  location  = "uksouth"
  parent_id = "/subscriptions/${var.subscription_id}"
}
