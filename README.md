# Static S3 Webpage on AWS 
Using Terraform and Terragrunt to create a secure static webpage in AWS for the Mozilla Hub's Team "Take Home Test".\
Completed By: Liz Kopiec

## Soulution Explanation
### Overview
For my solution to this take home assesment I chose to use Terraform and Terragrunt to provision the AWS services needed to host a static webpage. I also wanted to focus on the 'secure' aspect of requirements so I chose to host a simple static webpage in S3 and include AWS services to secure this webpage and the bucket it's housed in.

Some decisions I made while creating this solution:
- To manually create IAM users/groups/policies, the S3 bucket to house the Terraform state file and the DynamoDB
- To showcase the use of Terragrunt's ability to use git tags in the Terraform module source by creating lower and production environments where the lower environemnt is using a tagged commit  further ahead of the production environment to simulate how changes would be tested before deployed.
- To write about how I would properly provision IAM policies rather than implementing them, to save some time

### Tools 
- Terraform - infrastructure provisioning in AWS
- Terragrunt - avoid repeating backend, provider and module code
- Git - versioning of code

### AWS Services
- S3
    - Hosts the index.html page
    - Stores the Terraform state file
- DynamoDB
    - Used to store Terraform state file locking data
- Route53
    - DNS zone
    - DNS records
    - domain registration
- CloudFront
    - secure the S3 bucket from public access/attacks
    - cache content to protect against DDos to the origin (S3 bucket)
- AWS Certificate Manager
    - create an SSL cert to secure the webpage
- IAM
    - create users and groups for each specific environment to control access to resources.


### Enhancements for the future
a

## Deploying the Application
### Prerequisites
- Package versions:
    - Terraform v1.0.0
    - Terragrunt v0.30.3
- IAM Users -  these user's shopuld be defined as profiles in ~/.aws/credentials
    - terraform-user-uat - group: uat
    - terraform-user-prod - group: prod

- IAM Groups:
    - "uat"
        - IAM Policies:
    - "prod"
        - IAM Policies:
- Domain purchased
- S3 Backend for Terraform state created
- DynamoDB for Terraform state locking created


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