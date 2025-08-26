# Generate TLS Private Key
resource "tls_private_key" "eks_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS Key Pair
resource "aws_key_pair" "eks_key_pair" {
  key_name   = local.key_pair_name
  public_key = tls_private_key.eks_key.public_key_openssh

  tags = merge(local.common_tags, {
    ResourceType = "key-pair"
    Purpose      = "eks-node-access"
  })
}

# Save Private Key to Local File
resource "local_file" "eks_private_key" {
  content              = tls_private_key.eks_key.private_key_pem
  filename             = "${path.module}/${local.key_pair_name}.pem"
  file_permission      = "0600"
  directory_permission = "0700"
}
