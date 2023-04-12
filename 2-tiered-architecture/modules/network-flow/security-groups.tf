# Create security group for ALB
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


# Allow SSH Access
  ingress {
    from_port       = var.ssh_port
    to_port         = var.ssh_port
    protocol        = "tcp"
    security_groups = "10.0.0.0/16"  
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


# Creating Security Group for Auto-Scaling Group

resource "aws_security_group" "asg-sg" {
  name   = var.asg_sg_name
  vpc_id = aws_vpc.terraform-vpc.id

  # Inbound Rules

  # Allow HTTP Access ALB
  ingress {
    from_port       = var.http_port
    to_port         = var.http_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }


  # Allow SSH Access from ALB
  ingress {
    from_port       = var.http_port
    to_port         = var.http_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]  
  }


  # Outbound Rules
  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.asg_sg_egress_cidr_blocks
  }
}




# Creating Security Group for Database

resource "aws_security_group" "lt-sg" {
  name   = var.lt_sg_name
  vpc_id = aws_vpc.terraform-vpc.id

  # Inbound Rules

  # Allow Access from Web Tier through MySQL default Port
  ingress {
    from_port       = var.mysql_port
    to_port         = var.mysql_port
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