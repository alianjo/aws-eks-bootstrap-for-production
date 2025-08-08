terraform {
  backend "s3" {
    bucket = "terraform-on-aws-eks-pro"
    key    = "eks-cluster/terraform.tfstate"
    region = "us-east-1" 
 
    # For State Locking
  }  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.20"
    }    
  }
}
