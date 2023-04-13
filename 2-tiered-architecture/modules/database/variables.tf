#####################################
#Database Variables
#####################################

#Database Subnet Group
#####################################
variable "db_sub_name" {
  default = "two tier db subnet group"
  type    = string
}

variable "priv_sub1_id" {}
variable "priv_sub2_id" {}

#Database
#####################################
variable "allocated_storage" {
  type = number
}

variable "storage_type" {}
variable "engine" {}

variable "engine_version" {
  type = number
}
variable "instance_class" {}
variable "vpc_security_group_ids" {}
variable "parameter_group_name" {}
variable "db_name" {}
variable "username" {}
variable "password" {}

variable "allow_major_version_upgrade" {
  type = bool
}
variable "auto_minor_version_upgrade" {
  type = bool
}
variable "backup_retention_period" {
  type = number
}
variable "backup_window" {}
variable "maintenance_window" {}

variable "multi_az" {
  type = bool
}
variable "skip_final_snapshot" {
  type = bool
}


