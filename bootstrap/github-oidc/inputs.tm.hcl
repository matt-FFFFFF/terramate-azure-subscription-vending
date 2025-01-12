generate_file "terraform.tfvars.json" {
  content = tm_jsonencode({
    location        = global.bootstrap.location
    repository_name = global.github.repository_name
    subscription_id = global.bootstrap.subscription_id
    tenant_id       = global.bootstrap.tenant_id
  })
}
