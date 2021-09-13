# PUBLIC
resource "aws_route_table" "eks-table" {
  vpc_id = "${aws_vpc.eks-vpc.id}"

}

resource "aws_route" "pub-routes" {
  route_table_id         = "${aws_route_table.eks-table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.eks-igateway.id}"
}

resource "aws_route_table_association" "ass-pub-table" {
  count          = length(var.azs)
  subnet_id      = "${aws_subnet.pub-subnets[count.index].id}"
  route_table_id = "${aws_route_table.eks-table.id}"
}

# PRIVATE
resource "aws_route_table" "priv_tables" {
  vpc_id = "${aws_vpc.eks-vpc.id}"
  count  = length(var.azs)
}

resource "aws_route" "priv_routes" {
  count           = length(var.azs)
  route_table_id  = "${aws_route_table.priv_tables[count.index].id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id  = "${aws_nat_gateway.eks_NAT[count.index].id}"
}

resource "aws_route_table_association" "priv_ass" {
  count           = length(var.azs)
  subnet_id       = "${aws_subnet.priv-subnets[count.index].id}"
  route_table_id  = "${aws_route_table.priv_tables[count.index].id}"
}