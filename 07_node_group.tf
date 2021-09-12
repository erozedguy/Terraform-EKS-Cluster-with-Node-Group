resource "aws_eks_node_group" "node-ec2" {
  cluster_name    = "${aws_eks_cluster.eks-cluster.name}"
  node_group_name = "node_group"
  node_role_arn   = "${data.aws_iam_role.nodeGroupRole.arn}"
  subnet_ids      = "${aws_subnet.pub-subnets[*].id}"

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  ami_type       = "AL2_x86_64"
  instance_types = ["t3.micro"]
  capacity_type = "ON_DEMAND"
  disk_size      = 20

}