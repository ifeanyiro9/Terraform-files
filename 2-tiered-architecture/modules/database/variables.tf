#####################################
#Database Variables
#####################################

#Database Subnet Group
#####################################
variable "db-sub-name" {
  default = "Two tier db subnet group"
  type    = string
}

variable "pub-sub1-id" {}
variable "pub-sub2-id" {}

#Database
#####################################
variable "allocated-storage" {
    type = number
}

variable "storage-type" {}
variable "engine" {}

variable "engine-version" {
    type = number
}
variable "instance-class" {}
variable "vpc-security-group-ids" {}
variable "parameter-group-name" {}
variable "db-name" {}
variable "db-name" {}
variable "password" {}

variable "allow-major-version-upgrade" {
    type = bool
}
variable "auto-minor-version-upgrade" {
    type = bool
}
variable "backup-retention-period" {
    type = number
}
variable "backup-window" {}
variable "maintenance-window" {}

variable "multi-az" {
    type = bool
}
variable "skip-final-snapshot" {
    type = bool
}


