data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_eks_cluster" "eks-cluster" {
  name = aws_eks_cluster.eks-cluster.name
}

locals {
  oidc = trimprefix(data.aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer, "https://")
}