generate_file "terraform.tfvars" {
  content = <<CONTENT
management_group_name = "${terramate.stack.path.basename}"
CONTENT
}
