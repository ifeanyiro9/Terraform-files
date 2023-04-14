#####################################
#VPC Variables - Parent Module 
####################################

variable "pm_vpc_cidr" {
  default = "10.0.0.0/16"
  type    = string
}

variable "db_password" {
  type      = string
  default   = "password"
  sensitive = true
}