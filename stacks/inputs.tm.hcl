generate_file "terraform.tfvars" {
  content = <<CONTENT
management_group_name = "${tm_reverse(tm_split("/", terramate.stack.path.relative))[1]}"
CONTENT
}
