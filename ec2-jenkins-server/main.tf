terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

resource "aws_instance" "jenkins" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = [aws_security_group.jenkins-sg.id]
  user_data                   = "${file("install_jenkins.sh")}"
  iam_instance_profile        = "${ws_iam_role.s3-jenkins-role.name}"
  
  tags   = {
    Name = var.jenkins-tag-name
  }
  
  
}

resource "aws_s3_bucket" "jenkins-s3-bucket" {
  bucket = var.bucket
  acl    = var.acl
  
  tags   = {
    Name = var.jenkins-tag-name
  }
}



