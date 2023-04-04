resource "aws_vpc" "terraform-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = var.resource_tag
  }
}

resource "aws_subnet" "pub-sub1" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.availability_zone-2
  map_public_ip_on_launch = true

  tags = {
    Name = var.resource_tag
  }
}

resource "aws_subnet" "pub-sub2" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.availability_zone-2
  map_public_ip_on_launch = true

  tags = {
    Name = var.resource_tag
  }
}


resource "aws_subnet" "priv-sub1" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = var.availability_zone-1
  map_public_ip_on_launch = true

  tags = {
    Name = var.resource_tag
  }
}

resource "aws_subnet" "priv-sub2" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = var.availability_zone-2
  map_public_ip_on_launch = true

  tags = {
    Name = var.resource_tag
  }
}

# Internet Gateway
resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "var.resource_tag"
  }
}


resource "aws_eip" "ngw-eip" {
  vpc = true
}

resource "aws_nat_gateway" "terraform-ngw" {
  allocation_id = aws_eip.ngw-eip.id
  subnet_id     = aws_subnet.pub-sub1.id

  tags = {
    Name = var.resource_tag
  }

  depends_on = [aws_internet_gateway.terraform-igw]
}


resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-igw.id
  }

  tags = {
    Name = "var.resource_tag"
  }
}


resource "aws_route_table" "priv-rt" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.terraform-ngw.id
  }

  tags = {
    Name = "var.resource_tag"
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