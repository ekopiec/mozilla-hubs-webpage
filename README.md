# Static S3 Webpage on AWS (take home test completed by Liz Kopiec)


Using Terraform and Terragrunt to create a secure static webpage in AWS.

## Prerequisites
- Package versions:
    - Terraform v1.0.0
    - Terragrunt v0.30.3
- IAM Users:
    - terraform-user-uat 
    - terraform-user-prod 
- IAM Groups and membership
    - uat
        - terraform-user-uat
    - prod
        - terraform-user-prod
- Domain 
- S3 Backend for Terraform state.
- DynamoDB for Terraform state locking.

## AWS Services:
- S3 - hosts the webpage
- Route53 - provides domain resolution
- AWS Certificate Manager (ACM) - provides SSL certificates
- CloudFront - provides protection of the origin (S3 bucket)
- IAM - provides user and group permissions

## How To Use

### Basics

### Testing Module Updates

### 

## Terragrunt Configuration
Terragrunt is used to stop the replication of provider, backend and module code.

The backend (remote_state) configuration is included from the parent directory's terragrunt.hcl in each child directory of the environement (for example: uat/webpage/terragrunt.hcl)

The provider configuration is generated for each child directory from the parent directory's terragrunt.hcl. This generated file can be found under .terragrunt_cache.

Each


Requirements:
Explain your solution.
Provide instructions for how to deploy and manage the application.
Note any assumptions or decisions you had to make because the problem was under-specified.
What would you like to have asked before implementing a solution?
● Assume you are writing for a technical audience who are less familiar with the tools than you are.