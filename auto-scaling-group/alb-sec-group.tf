# Create security group for ALB
resource "aws_security_group" "alb-sg" {
   # Set name and description of the security group
  name        = "alb-sg"
  description = "Security Group for the App Load Balancer"
  
  # Set the VPC ID where the security group will be created
  vpc_id      = aws_vpc.terraform-vpc.id
  depends_on  = [aws_vpc.terraform-vpc]

  # Inbound Rule
  # HTTP access from anywhere
  ingress {
    description = "Allow HTTP Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access from anywhere
  ingress {
    description = "Allow SSH Traffic"
    from_port   = 22
    to_port     = 22
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
    Name = "ALB SG"
  }
}



