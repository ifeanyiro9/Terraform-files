resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-igw.id
  }

  tags = {
    Name = var.pub-rt-name
  }
}


resource "aws_route_table" "priv-rt" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.terraform-ngw.id
  }

  tags = {
    Name = var.priv-rt-name
  }
}



resource "aws_route_table_association" "pub-sub1-rt-ass" {
  subnet_id      = aws_subnet.pub-sub1.id
  route_table_id = aws_route_table.pub-rt.id
}


resource "aws_route_table_association" "pub-sub2-rt-ass" {
  subnet_id      = aws_subnet.pub-sub2.id
  route_table_id = aws_route_table.pub-rt.id
}


resource "aws_route_table_association" "priv-sub1-rt-ass" {
  subnet_id      = aws_subnet.priv-sub1.id
  route_table_id = aws_route_table.priv-rt.id
}


resource "aws_route_table_association" "priv-sub2-rt-ass" {
  subnet_id      = aws_subnet.priv-sub2.id
  route_table_id = aws_route_table.priv-rt.id
}