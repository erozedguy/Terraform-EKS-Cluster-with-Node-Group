resource "aws_eks_cluster" "eks-cluster" {
  name      = "eks-cluster"
  role_arn  = "${aws_iam_role.EKSClusterRole.arn}"
  version   = "1.21"

  vpc_config {
    subnet_ids          = ["${aws_subnet.pub-subnets[0].id}",
                           "${aws_subnet.pub-subnets[1].id}",
                           "${aws_subnet.priv-subnets[0].id}",
                           "${aws_subnet.priv-subnets[1].id}"]
    security_group_ids  = ["${aws_security_group.sg1-ssh.id}"]
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy
  ]

}