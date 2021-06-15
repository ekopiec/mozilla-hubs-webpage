#Create a provider.tf file that uses the AWS role "webpage_uat"
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = << EOF
    provider "aws" {
      profile = "terraform-user-prod"
      region = "us-east-1"
    }
  EOF
}

remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "terraform-state-4c89"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "us-east-1 "
    encrypt = "true"
    dynamodb_table = "terraform-state-prod"
  }
}
