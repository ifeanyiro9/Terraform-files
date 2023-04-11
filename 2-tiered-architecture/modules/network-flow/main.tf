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



# Create an internet gateway and associate it with the VPC
resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = var.igw-name
  }
}

# Create an Elastic IP address
resource "aws_eip" "ngw-eip" {
  vpc = true
}

# Create a NAT gateway and associate it with an Elastic IP and a public subnet
resource "aws_nat_gateway" "terraform-ngw" {
  allocation_id = aws_eip.ngw-eip.id     # Associate the NAT gateway with the Elastic IP
  subnet_id     = aws_subnet.pub-sub1.id # Associate the NAT gateway with a public subnet

  tags = {
    Name = var.nat-gw-name
  }

  depends_on = [aws_internet_gateway.terraform-igw] # Make sure the internet gateway is created before creating the NAT gateway
}




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






# Create security group for web tier
resource "aws_security_group" "alb-sg" {
  # Set name and description of the security group
  name        = var.alb_sg_name
  description = var.alb_sg_description

  # Set the VPC ID where the security group will be created
  vpc_id     = aws_vpc.terraform-vpc.id
  depends_on = [aws_vpc.terraform-vpc]

  # Inbound Rule
  # HTTP access from anywhere
  ingress {
    description = "Allow HTTP Traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = var.alb_sg_ingress_cidr_blocks
  }

  # SSH access from anywhere
  ingress {
    description = "Allow SSH Traffic"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = var.alb_sg_ingress_cidr_blocks
  }

  # Inbound Rule
  # Allow all egress traffic
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = var.alb_sg_egress_cidr_blocks
  }

  # Set tags for the security group
  tags = {
    Name = "ALB SG"
  }
}


# Creating Security Group for database
resource "aws_security_group" "lt-sg" {
  name   = var.lt_sg_name
  vpc_id = aws_vpc.terraform-vpc.id

  # Inbound Rules
  # HTTP access from anywhere
  ingress {
    from_port       = var.http_port
    to_port         = var.http_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }

  # SSH access from anywhere
  ingress {
    from_port       = var.ssh_port
    to_port         = var.ssh_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }

  # Outbound Rules
  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.lt_sg_egress_cidr_blocks
  }
}