resource "aws_security_group" "sg1-ssh" {
  name        = "ssh"
  description = "Port 22"
  vpc_id      = "${aws_vpc.eks-vpc.id}"

  ingress {
    description      = "Allow Port 22"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description = "Allow all ip and ports outboun"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

