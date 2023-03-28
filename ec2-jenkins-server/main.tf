terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "jenkins" {
  ami           = ami-00c39f71452c08778
  instance_type = "t2.micro"
  key_name      = "levelupkeypair"
  vpc_security_group_ids

  tags = {
    Name = "Jenkins-Server"
  }
}

resource "aws_security_group" "jenkins-sg" {
    name = "jenkins-sg"
    decription = "Allow Port 22 and 8080"
    
    
    ingress {
        description      = "Allow SSH Traffic"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = [aws_vpc.main.cidr_block]
        ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
        
    }
    
    ingress {
        description      = "Allow 8080 Traffic"
        from_port        = 8080
        to_port          = 8080
        protocol         = "tcp"
        cidr_blocks      = [aws_vpc.main.cidr_block]
        ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
        
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}
