locals {
  environment = var.environment
  name        = "${var.team}-${var.environment}-${var.cluster_name}-eks-cluster"
  eks_user    = "${var.cluster_name}-admin"
  common_tags = {
    environment = local.environment
    name        = local.name
  }
}