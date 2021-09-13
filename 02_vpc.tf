# VPC
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
  cidr_block              = "${var.pub-subnets[count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "eks-pub-subnets"
  }
}

# PRIVATE SUBNETS
resource "aws_subnet" "priv-subnets" {
  count                   = length(var.azs)
  vpc_id                  = "${aws_vpc.eks-vpc.id}"
  availability_zone       = "${var.azs[count.index]}"
  cidr_block              = "${var.priv-subnets[count.index]}"
  map_public_ip_on_launch = false

  tags = {
    Name = "eks-priv-snets"
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "eks-igateway" {
  vpc_id = "${aws_vpc.eks-vpc.id}"

  tags = {
    Name = "eks-igtw"
  }
}

# EIPs
resource "aws_eip" "e-ip" {
  count       = "${length(var.azs)}"
  vpc         = true
  depends_on  = [
                aws_internet_gateway.eks-igateway
  ]

  tags = {
    Name = "eip-${count.index}"
  }
}

# NAT GATEWAYS
resource "aws_nat_gateway" "eks_NAT" {
  count             = length(var.azs)
  subnet_id         = "${aws_subnet.pub-subnets[count.index].id}"
  connectivity_type = "public"
  allocation_id     = "${aws_eip.e-ip[count.index].id}"
  depends_on        = [
                        aws_internet_gateway.eks-igateway
  ]
}