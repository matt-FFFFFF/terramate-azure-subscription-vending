resource "terraform_data" "inputs" {
  input = {
    management_group_name = var.management_group_name
  }
}
