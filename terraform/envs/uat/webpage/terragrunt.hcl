#Include config from root terragrunt.hcl
include {
  path = find_in_parent_folders()
}

terraform {
  source = " "
}
inputs = {
}
