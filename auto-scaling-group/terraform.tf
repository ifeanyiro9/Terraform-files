# Declare the required version of Terraform
terraform {
  required_version = ">= 1.4.0"
  
  # Declare the required provider and its version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}