resource "tls_private_key" "eks_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "eks_key_pair" {
  key_name   = "eks-terraform-key"
  public_key = tls_private_key.eks_key.public_key_openssh
}

resource "local_file" "eks_private_key" {
  content              = tls_private_key.eks_key.private_key_pem
  filename             = "${path.module}/eks-terraform-key.pem"
  file_permission      = "0600"
  directory_permission = "0700"
}
