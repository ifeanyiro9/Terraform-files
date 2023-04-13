# Creates a public route table with a default route to the internet gateway
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.two_tier_vpc.id

  # Create a default route for the internet gateway with destination 0.0.0.0/0
  route {
    cidr_block = var.pub_rt_cidr
    gateway_id = aws_internet_gateway.two_tier_igw.id
  }

  tags = {
    Name = var.pub_rt_name
  }
}

# Creates a private route table with a default route to the NAT gateway
resource "aws_route_table" "priv_rt" {
  vpc_id = aws_vpc.two_tier_vpc.id

  route {
    cidr_block = var.priv_rt_cidr
    gateway_id = aws_nat_gateway.two_tier_ngw.id
  }

  tags = {
    Name = var.priv_rt_name
  }
}

# Associates the public route table with the public subnet 1
resource "aws_route_table_association" "pub_sub1_rt_ass" {
  subnet_id      = aws_subnet.pub_sub1.id
  route_table_id = aws_route_table.pub_rt.id
}

# Associates the public route table with the public subnet 2
resource "aws_route_table_association" "pub_sub2_rt_ass" {
  subnet_id      = aws_subnet.pub_sub2.id
  route_table_id = aws_route_table.pub_rt.id
}

# Associates the private route table with the private subnet 1
resource "aws_route_table_association" "priv_sub1_rt_ass" {
  subnet_id      = aws_subnet.priv_sub1.id
  route_table_id = aws_route_table.priv_rt.id

  # Wait for the private route table to be created before creating this association
  depends_on = [aws_route_table.priv_rt]
}

# Associates the private route table with the private subnet 2
resource "aws_route_table_association" "priv_sub2_rt_ass" {
  subnet_id      = aws_subnet.priv_sub2.id
  route_table_id = aws_route_table.priv_rt.id

  # Wait for the private route table to be created before creating this association
  depends_on = [aws_route_table.priv_rt]
}