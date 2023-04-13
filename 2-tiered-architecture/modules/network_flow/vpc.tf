# Create an AWS VPC
resource "aws_vpc" "two_tier_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.vpc_instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = var.vpc_name
  }
}

# Create first public subnet in the VPC
resource "aws_subnet" "pub_sub1" {
  vpc_id                  = aws_vpc.two_tier_vpc.id
  cidr_block              = var.pub_sub1_cidr
  availability_zone       = var.az_1
  map_public_ip_on_launch = var.map_public_ip

  tags = {
    Name = var.pub_sub1_name
  }
}

# Create second public subnet in the VPC
resource "aws_subnet" "pub_sub2" {
  vpc_id                  = aws_vpc.two_tier_vpc.id
  cidr_block              = var.pub_sub2_cidr
  availability_zone       = var.az_2
  map_public_ip_on_launch = var.map_public_ip

  tags = {
    Name = var.pub_sub2_name
  }
}

# Create first private subnet in the VPC
resource "aws_subnet" "priv_sub1" {
  vpc_id            = aws_vpc.two_tier_vpc.id
  cidr_block        = var.priv_sub1_cidr
  availability_zone = var.az_1

  tags = {
    Name = var.priv_sub1_name
  }
}

# Create second private subnet in the VPC
resource "aws_subnet" "priv_sub2" {
  vpc_id            = aws_vpc.two_tier_vpc.id
  cidr_block        = var.priv_sub2_cidr
  availability_zone = var.az_2

  tags = {
    Name = var.priv_sub2_name
  }
}