data "aws_availability_zones" "azs" {

}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
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
  tags                    = local.common_tags
  vpc_tags = {
    created_for = "eks-cluster"
  }

}
