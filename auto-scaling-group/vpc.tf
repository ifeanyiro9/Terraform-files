# Create an AWS VPC
resource "aws_vpc" "terraform-vpc" {
  cidr_block       = var.vpc-cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

# Create first public subnet in the VPC
resource "aws_subnet" "pub-sub1" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = var.pub_sub1_cidr
  availability_zone       = var.availability_zone-1
  map_public_ip_on_launch = true

  tags = {
    Name = var.pub-sub1-name
  }
}

# Create second public subnet in the VPC
resource "aws_subnet" "pub-sub2" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = var.pub_sub2_cidr
  availability_zone       = var.availability_zone-2
  map_public_ip_on_launch = true

  tags = {
    Name = var.pub-sub2-name
  }
}

# Create first private subnet in the VPC
resource "aws_subnet" "priv-sub1" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = var.priv_sub1_cidr
  availability_zone       = var.availability_zone-1
  map_public_ip_on_launch = true

  tags = {
    Name = var.priv-sub1-name
  }
}

# Create second private subnet in the VPC
resource "aws_subnet" "priv-sub2" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = var.priv_sub2_cidr
  availability_zone       = var.availability_zone-2
  map_public_ip_on_launch = true

  tags = {
    Name = var.priv-sub2-name
  }
}