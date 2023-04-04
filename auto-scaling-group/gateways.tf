# Internet Gateway
resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = var.igw-name
  }
}


resource "aws_eip" "ngw-eip" {
  vpc = true
}

resource "aws_nat_gateway" "terraform-ngw" {
  allocation_id = aws_eip.ngw-eip.id
  subnet_id     = aws_subnet.pub-sub1.id

  tags = {
    Name = var.nat-gw-name
  }

  depends_on = [aws_internet_gateway.terraform-igw]
}
