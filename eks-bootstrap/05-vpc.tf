data "aws_availability_zones" "azs" {

}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpc_name_full
  cidr = var.vpc_cidr_block

  azs             = data.aws_availability_zones.azs.names
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway

  database_subnets                   = var.vpc_database_subnets
  create_database_subnet_group       = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table

  enable_dns_hostnames    = true
  enable_dns_support      = true
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    ResourceType = "vpc"
  })

  public_subnet_tags = {
    "kubernetes.io/role/elb"                           = "1"
    "kubernetes.io/cluster/${local.cluster_name_full}" = "owned"
    Name                                               = "${local.name_prefix}-public-subnet"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"                  = "1"
    "kubernetes.io/cluster/${local.cluster_name_full}" = "owned"
    Name                                               = "${local.name_prefix}-private-subnet"
  }

  database_subnet_tags = {
    Name = "${local.name_prefix}-database-subnet"
  }

  vpc_tags = {
    ResourceType = "vpc"
    Purpose      = "eks-cluster"
  }
}
