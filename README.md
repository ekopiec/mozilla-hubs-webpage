# Static S3 Webpage on AWS (take home test completed by Liz Kopiec)

Using Terraform and Terragrunt to create a secure static webpage in AWS.

## Prerequisites
Package versions:
- Terraform v1.0.0
- Terragrunt v0.30.3

IAM Users:
- terraform-user-uat - in the uat group
- terraform-user-prod - in the prod group

IAM Groups
- uat
- prod

Domain: 

## AWS Services Used:
- S3 - hosts the webpage
- Route53 - provides domain resolution
- AWS Certificate Manager (ACM) - provides SSL certificates
- CloudFront - provides protection of the origin (S3 bucket)
- IAM - provides user and group permissions

## How To Use

### Basics

### Testing Module Updates

### 