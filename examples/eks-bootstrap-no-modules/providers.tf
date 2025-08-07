provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host = aws_eks_cluster.eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
}