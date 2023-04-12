#####################################
#Auto Scaling Group Variables
#####################################
variable "asg-name" {
  default = "Two tier asg"
  type    = string
}

variable "asg-min" {
  type        = number
  default     = 2
}

variable "asg-max" {
  type        = number
  default     = 5
}

variable "asg-des-cap" {
  type        = number
  description = "ASG Desired Capacity"
  default     = 2
}

variable "pub-sub1-id" {}
variable "pub-sub2-id" {}

variable "asg-tag-name" {
  default = "Two Tier ASG"
  type    = string
}

#Launch Template
variable "lt-asg-name" {
  default = "Two tier lt-asg"
  type    = string
}

variable "lt-asg-ami" {
  type        = string
  description = "Amazon Linux 2 Ami ID"
  default     = "ami-04581fbf744a7d11f"
}

variable "lt-asg-instance-type" {
  type        = string
  default     = "t2.micro"
}

variable "lt-asg-key" {
  type        = string
  description = "Key Pair"
  default     = "levelupkeypair"
}

variable "script-name" {
  type        = string
  description = "User Data Script"
  default     = "install-apache.sh"
}
