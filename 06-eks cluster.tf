resource "aws_eks_cluster" "eks-cluster" {
  name     = "eks-cluster"
  role_arn = "${data.aws_iam_role.eksclusterole.arn}"

  vpc_config {
    subnet_ids = ["${aws_subnet.pub-subnets[0].id}",
    "${aws_subnet.pub-subnets[1].id}"]
    security_group_ids = ["${aws_security_group.sg1-ssh.id}"]
  }

}