data "aws_iam_role" "eksclusterole" {
  name = "eksClusterRole"
}
data "aws_iam_role" "nodeGroupRole" {
  name = "NodeGroupRole"
}
