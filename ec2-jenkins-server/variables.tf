variable "aws_region" {
   default = "us-east-1"
   type    = string
}

variable "ami" {
   default = "ami-00c39f71452c08778"
   type    = string
}

variable "instance_type" {
	default = "t2.micro"
	type    = string
}

variable "key_name" {
   default = "levelupkeypair"
   type    = string
}

variable "associate_public_ip_address" {
   default = "true"
   type    = bool
}

variable "jenkins-tag-name" {
   default = "Jenkins-Server"
   type    = string
}




variable "bucket" {
    default = "jenkins-s3-bucket-ifeanyi-luit20"
    type    = string
}

variable "acl" {
    default = "private"
    type    = string
}

variable "policy_arn" {
    default = "arn:aws:iam::aws:policy/AmazonS3ReadWriteAccess"
    type    = string
}