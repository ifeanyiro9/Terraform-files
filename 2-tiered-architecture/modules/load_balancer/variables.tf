#####################################
#Load Balancer Variables
#####################################
variable "pub_sub_alb_name" {
  default = "Two tier public subnet"
  type    = string
}


variable "pub_sub1_id" {}
variable "pub_sub2_id" {}
variable "alb_sg_id" {}

variable "pub_sub_alb_tag" {
  default = "Two Tier Public Subnet ALB"
  type    = string
}

#Target Group
variable "target_group_name" {
  default = "Two Tier Target Group"
  type    = string
}

variable "tg_port" {}
variable "tg_protocol" {}
variable "vpc_id" {}
variable "alb_hc_interval" {}
variable "alb_hc_path" {}
variable "alb_hc_port" {}
variable "alb_hc_timeout" {}
variable "alb_hc_protocol" {}
variable "alb_hc_matcher" {}

#ALB Listener
variable "alb_listener_port" {}
variable "alb_listener_protocol" {}


