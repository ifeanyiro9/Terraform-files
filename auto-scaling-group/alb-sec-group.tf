# Create security group for ALB
resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Security Group for the App Load Balancer"
  vpc_id      = aws_vpc.terraform-vpc.id
  depends_on = [aws_vpc.terraform-vpc]

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


  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB SG"
  }
}


