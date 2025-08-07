provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host = aws_eks_cluster.eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.cert)
}