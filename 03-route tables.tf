resource "aws_route_table" "eks-table" {
  vpc_id = "${aws_vpc.eks-vpc.id}"

  tags = {
    Name = "eks-rtable"
  }
}

resource "aws_route" "eks-routes" {
  route_table_id         = "${aws_route_table.eks-table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.eks-igateway.id}"
}

resource "aws_route_table_association" "ass-eks-table" {
  count          = length(var.azs)
  subnet_id      = "${aws_subnet.pub-subnets[count.index].id}"
  route_table_id = "${aws_route_table.eks-table.id}"
}