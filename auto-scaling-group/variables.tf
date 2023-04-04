variable "aws_region" {
  default = "us-east-1"
  type    = string
}

variable "resource_tag" {
  default = "Terraform ASG"
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