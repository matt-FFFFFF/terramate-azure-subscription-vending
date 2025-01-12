generate_file "terraform.tfvars.json" {
  content = tm_jsonencode({
    management_group_name = "${tm_reverse(tm_split("/", terramate.stack.path.relative))[1]}"
  })
}
