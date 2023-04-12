# Create security group for ALB
resource "aws_security_group" "alb-sg" {
  # Set name and description of the security group
  name        = var.alb_sg_name
  description = "Allow HTTP traffic"

  # Set the VPC ID where the security group will be created
  vpc_id     = aws_vpc.two-tier-vpc.id
  depends_on = [aws_vpc.two-tier-vpc]

  # Inbound Rule
  # HTTP access from anywhere
  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound Rule
  # Allow all egress traffic
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Set tags for the security group
  tags = {
    Name = var.alb-gw-tag-name
  }
}


# Create Security Group for Auto-Scaling Group
resource "aws_security_group" "asg-sg" {
  name   = var.asg_sg_name
  vpc_id = aws_vpc.two-tier-vpc.id

  # Inbound Rules
  # Allow HTTP Access from ALB Security Group
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }

  # Allow SSH Access to public facing ASG
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
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

# Create Security group for database tier
resource "aws_security_group" "db_sg" {
  name        = var.db_sg_name
  vpc_id      = aws_vpc.two-tier-vpc.id
 
  # Inbound Rules
  # Allow Access from Web Tier
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.asg-sg.id]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.asg-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }