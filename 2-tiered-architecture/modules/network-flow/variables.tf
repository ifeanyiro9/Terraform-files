#####################################
#VPC Variables
#####################################
variable "vpc-cidr" {
  default = "10.0.0.0/16"
  type    = string
}

variable "vpc-instance-tenancy" {
  default = "default"
  type    = string
}

variable "vpc_name" {
  default = "Two Tier VPC"
  type    = string
}

#####################################
#Public and Private Subnets Variables
#####################################
variable "pub_sub1_cidr" {
  default = "10.0.1.0/24"
  type    = string
}

variable "pub_sub2_cidr" {
  default = "10.0.2.0/24"
  type    = string
}

variable "priv_sub1_cidr" {
  default = "10.0.3.0/24"
  type    = string
}

variable "priv_sub2_cidr" {
  default = "10.0.4.0/24"
  type    = string
}

variable "map-public-ip" {
    default = "true"
    type    = bool
}

variable "pub-sub1-name" {
  default = "Two Tier Public Subnet 1"
  type    = string
}

variable "pub-sub2-name" {
  default = "Two Tier Public Subnet 2"
  type    = string
}

variable "priv-sub1-name" {
  default = "Two Tier Private Subnet 1"
  type    = string
}

variable "priv-sub2-name" {
  default = "Two Tier Private Subnet 2"
  type    = string
}

#####################################
#Availability Zone Variables
#####################################
variable "az-1" {
  default = "us-east-1a"
  type    = string
}

variable "az-2" {
  default = "us-east-1b"
  type    = string
}

#####################################
#Route Table Variables
#####################################
variable "pub_rt_cidr" {
  type        = string
  description = "CIDR block to route traffic from anywhere to internet gateway"
  default     = "0.0.0.0/0"
}

variable "priv_rt_cidr" {
  type        = string
  description = "CIDR block to route taffic from private subnet to natgateway"
  default     = "0.0.0.0/0"
}

variable "pub-rt-name" {
  default = "Two Tier Public Route Table"
  type    = string
}

variable "priv-rt-name" {
  default = "Two Tier Private Route Table"
  type    = string
}

#####################################
#Gateway Variables
#####################################
variable "igw-name" {
  default = "Two Tier Internet Gatway"
  type    = string
}

variable "nat-gw-name" {
  default = "Two Tier NAT Gateway"
  type    = string
}

#####################################
#Application Load Balancer Variables
#####################################
variable "alb_sg_name" {
  type        = string
  default     = "Two-tier-alb-sg"
}

variable "alb-gw-tag-name" {
  default = "Two Tier NAT Gateway"
  type    = string
}

#####################################
#ASG & Database Security Group Variables
#####################################
variable "asg_sg_name" {
  type        = string
  default     = "Two Tier alb-sg"
}

variable "db_sg_name" {
  type        = string
  default     = "Two Tier db-sg"
}