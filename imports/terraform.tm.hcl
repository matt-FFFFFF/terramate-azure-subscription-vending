generate_hcl "_terramate_generated_terraform.tf" {
  # condition = tm_contains(terramate.stack.tags, "terraform")

  lets {
    required_providers = { for k, v in tm_try(global.terraform.providers, {}) :
      k => {
        source  = v.source
        version = v.version
        } if tm_alltrue([
          tm_try(v.enabled, true),
          tm_length(tm_split(".", k)) == 1,
      ])
    }

    providers = { for k, v in tm_try(global.terraform.providers, {}) :
      k => v.config if tm_alltrue([
        tm_length(tm_split(".", k)) == 1,
        tm_try(v.enabled, true),
        tm_can(v.config)
      ])
    }

    providers_aliases = { for k, v in tm_try(global.terraform.providers, {}) :
      k => v.config if tm_alltrue([
        tm_length(tm_split(".", k)) == 2,
        tm_try(v.enabled, true),
        tm_can(v.config)
      ])
    }
  }

  content {
    # Terraform version constraints
    terraform {
      required_version = tm_try(global.terraform.version, "~> 1.9")
    }

    # Provider version constraints
    terraform {
      tm_dynamic "required_providers" {
        attributes = let.required_providers
      }
    }

    # Provider configs
    tm_dynamic "provider" {
      for_each   = let.providers
      labels     = [provider.key]
      attributes = provider.value

      content {
        tm_dynamic "features" {
          condition = provider.key == "azurerm"
          content {}
        }
      }
    }

    # Provider aliases
    tm_dynamic "provider" {
      for_each   = let.providers_aliases
      labels     = [tm_split(".", provider.key)[0]]
      attributes = provider.value


      content {
        alias = tm_split(".", provider.key)[1]

        tm_dynamic "features" {
          condition = provider.key == "azurerm"
          content {}
        }
      }
    }
  }
}
