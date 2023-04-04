variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "vpc_name" {
  default = "Terraform VPC"
  type    = string
}

variable "availability_zone-1" {
  default = "us-east-1a"
  type    = string
}

variable "availability_zone-2" {
  default = "us-east-1b"
  type    = string
}

variable "auto-assign-ip" {
  default = "true"
  type    = bool
}

variable "pub-sub1-name" {
  default = "Public Subnet 1"
  type    = string
}

variable "pub-sub2-name" {
  default = "Public Subnet 1"
  type    = string
}

variable "priv-sub1-name" {
  default = "Private Subnet 1"
  type    = string
}

variable "priv-sub2-name" {
  default = "Private Subnet 1"
  type    = string
}

variable "igw-name" {
  default = "Internet Gatway"
  type    = string
}

variable "nat-gw-name" {
  default = "Nat Gateway"
  type    = string
}

variable "pub-rt-name" {
  default = "Public Route Table"
  type    = string
}

variable "priv-rt-name" {
  default = "Private Route Table"
  type    = string
}
