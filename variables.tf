variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "Amazon machine Image ID"

}

variable "instance_type" {
  default = "t2.micro"

}

variable "key_name" {
  description = "SSH key pair name"

}

variable "vpc_id" {
  description = "VPC ID where the instance will be deployed"
}

variable "subnet_id" {
  description = "Subnet ID for EC2"
}

variable "ssh_cidr" {
  default     = "0.0.0.0/0"
  description = "CIDR blocks allowed to SSH"
}