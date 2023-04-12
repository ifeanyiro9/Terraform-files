#####################################
#Load Balancer Variables
#####################################
variable "pub-sub1-id" {}
variable "pub-sub2-id" {}
variable "alb-sg-id" {}

variable "pub-sub-alb-name" {
  default = "Two Tier Public Subnet ALB"
  type    = string
}

#Target Group
variable "target-group-name" {
  default = "Two Tier Target Group"
  type    = string
}

variable "tg-port" {}
variable "tg-protocol" {}
variable "vpc-id" {}
variable "alb-hc-interval" {}
variable "alb-hc-path" {}
variable "alb-hc-port" {}
variable "alb-hc-timeout" {}
variable "alb-hc-protocol" {}
variable "alb-hc-matcher" {}

#ALB Listener
variable "alb-arn" {}
variable "alb-listener-port" {}
variable "alb-listener-protocol" {}


