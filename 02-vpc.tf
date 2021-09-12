resource "aws_vpc" "eks-vpc" {
  cidr_block = "${var.cidr}"

  tags = {
    Name = "eks-vpc"
  }
}

# PUBLIC SUBNETS
resource "aws_subnet" "pub-subnets" {
  count                   = length(var.azs)
  vpc_id                  = "${aws_vpc.eks-vpc.id}"
  availability_zone       = "${var.azs[count.index]}"
  cidr_block              = "${var.subnets-ip[count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "eks-pub-snets"
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "eks-igateway" {
  vpc_id = "${aws_vpc.eks-vpc.id}"

  tags = {
    Name = "eks-igtw"
  }
}