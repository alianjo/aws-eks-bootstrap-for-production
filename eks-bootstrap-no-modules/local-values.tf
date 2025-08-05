locals {
  environment = var.environment
  name        = "${var.team}-${var.environment}-${var.cluster_name}-eks-cluster"
  common_tags = {
    environment = local.environment
    name        = local.name
  }
}