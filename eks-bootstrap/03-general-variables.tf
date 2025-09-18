variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.region))
    error_message = "Region must be a valid AWS region identifier."
  }
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod", "test"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod, test."
  }
}

variable "team" {
  description = "Team or project identifier for resource naming"
  type        = string
  default     = "devops"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.team))
    error_message = "Team must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "cluster_name" {
  description = "Base name for the EKS cluster and related resources"
  type        = string
  default     = "eksdemo"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.cluster_name))
    error_message = "Cluster name must contain only lowercase letters, numbers, and hyphens."
  }
}

