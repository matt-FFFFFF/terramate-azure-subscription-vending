globals "terraform" {
  version = "1.10.4"
}

globals "terraform" "providers" "azapi" {
  enabled = true

  source   = "azure/azapi"
  version  = "~> 2.2"
}

globals "terraform" "backend" "azurerm" {
  resource_group_name  = "tfstate"
  storage_account_name = "tfstatexscz2"
  container_name       = "tfstate"
}

globals "github"{
  repository_name = "terramate-azure-subscription-vending"
}
