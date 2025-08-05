variable "region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string
}

variable "environment" {
  description = "Environment variable as a prefix"
  type        = string
  default     = "dev"
}

variable "team" {
  description = "Which team is using this resource"
  type        = string
  default     = "devops"
}

