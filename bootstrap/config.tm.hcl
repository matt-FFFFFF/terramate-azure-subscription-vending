globals "terraform" "providers" "github" {
  enabled = true

  source  = "integrations/github"
  version = "~> 6.4"
  config = {
    owner = global.github.organization
  }
}
