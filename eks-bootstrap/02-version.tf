terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9"
    }

    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0"
    }
  }
}

# Note: Configure backend in terraform.tfvars or use terraform init -backend-config
# Example backend configuration:
# terraform {
#   backend "s3" {
#     bucket = "your-terraform-state-bucket"
#     key    = "eks-bootstrap/terraform.tfstate"
#     region = "us-east-1"
#   }
# }
