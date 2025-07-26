provider "aws" {
  region = var.aws_region
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name          = "prod-ec2"
  instance_type = var.instance_type
  ami           = var.ami_id
  key_name      = var.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [module.sg.security_group_id]

  associate_public_ip_address = true

  tags = {
    Name        = "prod-ec2"
    Environment = "production"
  }
}

module "sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "prod-ec2-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = [var.ssh_cidr]
  ingress_rules       = ["ssh-tcp", "http-80-tcp"]
  egress_rules        = ["all-all"]
}


