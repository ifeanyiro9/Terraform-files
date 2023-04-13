# Create an internet gateway and associate it with the VPC
resource "aws_internet_gateway" "two_tier_igw" {
  vpc_id = aws_vpc.two_tier_vpc.id

  tags = {
    Name = var.igw_name
  }
}

# Create an Elastic IP address
resource "aws_eip" "ngw_eip" {
  vpc = true
}

# Create a NAT gateway and associate it with an Elastic IP and a public subnet
resource "aws_nat_gateway" "two_tier_ngw" {
  allocation_id = aws_eip.ngw_eip.id     # Associate the NAT gateway with the Elastic IP
  subnet_id     = aws_subnet.pub_sub1.id # Associate the NAT gateway with a public subnet

  tags = {
    Name = var.nat_gw_name
  }

  depends_on = [aws_internet_gateway.two_tier_igw] # Make sure the internet gateway is created before creating the NAT gateway
}
