#####################################
#Auto Scaling Group Variables
#####################################
variable "asg_name" {
  default = "two tier asg"
  type    = string
}

variable "asg_min" {
  type    = number
  default = 2
}

variable "asg_max" {
  type    = number
  default = 5
}

variable "asg_des_cap" {
  type        = number
  description = "ASG Desired Capacity"
  default     = 2
}

variable "pub_sub1_id" {}
variable "pub_sub2_id" {}

variable "asg_tag_name" {
  default = "two tier asg"
  type    = string
}

#Launch Template
variable "lt_asg_name" {
  default = "two-tier-lt-asg"
  type    = string
}

variable "lt_asg_ami" {
  type        = string
  description = "Amazon Linux 2 Ami ID"
  default     = "ami-04581fbf744a7d11f"
}

variable "lt_asg_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "lt_asg_key" {
  type        = string
  description = "Key Pair"
  default     = "levelupkeypair"
}

variable "asg_sg_id" {}

variable "script_name" {
  type        = string
  description = "User Data Script"
  default     = "install-apache.sh"
}

variable "alb_tg_arn" {}