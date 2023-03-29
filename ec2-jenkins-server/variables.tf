variable "aws_region" {
   default = "us-east-1"
}

variable "ami" {
   default = "ami-00c39f71452c08778"
}

variable "instance_type" {
	default = "t2.micro"
}

variable "key_name" {
   default = "levelupkeypair"
}

variable "associate_public_ip_address" {
   default = "true"
}

variable "bucket" {
    defualt = "jenkins-s3-bucket-ifeanyi-luit20"
}

variable "acl" {
    default = "private"
}