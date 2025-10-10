locals {
  environment = var.environment
  team        = var.team
  name        = var.cluster_name

  # Consistent naming convention: {team}-{environment}-{cluster_name}-{resource-type}
  name_prefix = "${var.team}-${var.environment}-${var.cluster_name}"

  # Resource names
  cluster_name_full = "${local.name_prefix}-eks-cluster"
  vpc_name_full     = "${local.name_prefix}-vpc"
  key_pair_name     = "${local.name_prefix}-key-pair"

  # IAM role names
  cluster_role_name = "${local.name_prefix}-eks-cluster-role"
  node_role_name    = "${local.name_prefix}-eks-node-role"

  # Node group names
  private_node_group_name = "${local.name_prefix}-eks-ng-private"
  public_node_group_name  = "${local.name_prefix}-eks-ng-public"

  # Common tags with consistent naming
  common_tags = {
    Environment = title(local.environment)
    Team        = title(local.team)
    Project     = "eks-bootstrap"
    ManagedBy   = "terraform"
    Name        = local.cluster_name_full
  }
}