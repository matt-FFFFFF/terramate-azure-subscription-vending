resource "azapi_resource" "rg" {
  type      = "Microsoft.Resources/resourceGroups@2024-07-01"
  name      = "rg-${local.pseudo_random_resource_suffix}"
  location  = "uksouth"
  parent_id = "/subscriptions/${var.subscription_id}"
}
