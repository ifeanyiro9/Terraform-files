# Creates a public route table with a default route to the internet gateway
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.terraform-vpc.id

  # Create a default route for the internet gateway with destination 0.0.0.0/0
  route {
    cidr_block = var.pub_rt_cidr
    gateway_id = aws_internet_gateway.terraform-igw.id
  }

  tags = {
    Name = var.pub-rt-name
  }
}

# Creates a private route table with a default route to the NAT gateway
resource "aws_route_table" "priv-rt" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = var.priv_rt_cidr
    gateway_id = aws_nat_gateway.terraform-ngw.id
  }

  tags = {
    Name = var.priv-rt-name
  }
}

# Associates the public route table with the public subnet 1
resource "aws_route_table_association" "pub-sub1-rt-ass" {
  subnet_id      = aws_subnet.pub-sub1.id
  route_table_id = aws_route_table.pub-rt.id
}

# Associates the public route table with the public subnet 2
resource "aws_route_table_association" "pub-sub2-rt-ass" {
  subnet_id      = aws_subnet.pub-sub2.id
  route_table_id = aws_route_table.pub-rt.id
}

# Associates the private route table with the private subnet 1
resource "aws_route_table_association" "priv-sub1-rt-ass" {
  subnet_id      = aws_subnet.priv-sub1.id
  route_table_id = aws_route_table.priv-rt.id

  # Wait for the private route table to be created before creating this association
  depends_on = [aws_route_table.priv-rt]
}

# Associates the private route table with the private subnet 2
resource "aws_route_table_association" "priv-sub2-rt-ass" {
  subnet_id      = aws_subnet.priv-sub2.id
  route_table_id = aws_route_table.priv-rt.id

  # Wait for the private route table to be created before creating this association
  depends_on = [aws_route_table.priv-rt]
}