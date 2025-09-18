bucket         = "CHANGE_ME-terraform-state"
key            = "eks-bootstrap/dev/terraform.tfstate"
region         = "us-east-1"
encrypt        = true
dynamodb_table = "terraform-locks"

