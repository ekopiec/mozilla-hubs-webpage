#Generates a provider.tf for each subdirectory
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
    provider "aws" {
      profile = "terraform-user-prod"
      shared_credentials_file = "~/.aws/credentials"
      region = "us-east-1"
    }
  EOF
}

#Sets the backed to s3 for each subdirectory
remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "terraform-state-4c89"
    key = "${path_relative_to_include()}/prod/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "terraform-state-prod"
  }
}