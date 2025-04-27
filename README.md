# terraform-secure-aws
# Terraform Secure AWS Baseline

Secure-by-default Terraform modules to deploy a production-ready, hardened AWS environment.

## 🚀 Features

- Enforced least-privilege IAM roles
- Secure VPC with private/public subnet segmentation
- Encryption enabled for all storage (EBS, S3)
- CloudTrail and AWS Config enabled automatically
- Secrets managed through AWS Secrets Manager
- Network Security Groups with minimal, strict rules
- No public S3 buckets allowed by default
- GitHub Actions pipeline for security scans (tfsec, checkov)

## 📂 Repository Structure

```plaintext
terraform-secure-aws/
├── modules/
│   ├── vpc/
│   ├── ec2-instance/
│   ├── iam-roles/
│   ├── s3-bucket/
│   ├── cloudtrail/
├── examples/
│   ├── full-secure-setup/
├── .github/
│   └── workflows/
│       └── terraform-ci.yml
├── main.tf
├── variables.tf
├── outputs.tf
├── README.md
└── SECURITY.md

USAGE
# Clone the repository
git clone https://github.com/yourusername/terraform-secure-aws.git

# Navigate to the example setup
cd terraform-secure-aws/examples/full-secure-setup

# Initialize Terraform
terraform init

# Plan the infrastructure
terraform plan

# Apply the infrastructure
terraform apply

Prerequisites
Terraform >= 1.5

AWS CLI configured with appropriate permissions

Git

(Optional) tfsec and checkov installed for security scans

Security Tools Integrated

Tool             Purpose
tfsec	           Static analysis security scanner for Terraform
checkov	         Infrastructure as Code security and compliance scanner
GitHub Actions	 CI pipeline runs security checks on pull requests

Distributed under the MIT License.
