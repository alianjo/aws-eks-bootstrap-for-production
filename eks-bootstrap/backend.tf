# Backend Configuration
# Uncomment and modify these lines to configure S3 backend for state management
# This provides better collaboration, state locking, and versioning

# terraform {
#   backend "s3" {
#     bucket         = "your-terraform-state-bucket"
#     key            = "eks-bootstrap/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-locks"
#     kms_key_id     = "arn:aws:kms:us-east-1:ACCOUNT:key/KEY-ID"
#   }
# }

# To use this backend:
# 1. Create an S3 bucket for terraform state
# 2. Create a DynamoDB table for state locking
# 3. Uncomment the above configuration
# 4. Run: terraform init -reconfigure
