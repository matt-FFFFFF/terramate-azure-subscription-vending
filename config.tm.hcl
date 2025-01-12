globals "terraform" {
  version = "1.10.4"
}

globals "terraform" "providers" "azapi" {
  enabled = true

  source   = "azure/azapi"
  version  = "~> 2.2"
}

globals "terraform" "backend" "azurerm" {
  resource_group_name  = "rg-${global.pseudo_random_name}"
  storage_account_name = "stg${global.pseudo_random_name}"
  container_name       = "tfstate"
}

globals "github"{
  repository_name = "terramate-azure-subscription-vending"
}

globals {
  pseudo_random_name = tm_reverse(tm_split("-", tm_uuidv5("url", global.github.repository_name)))[0]
}
