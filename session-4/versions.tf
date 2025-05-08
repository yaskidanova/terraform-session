terraform {
  required_version = "~>1.11.0" #Terraform version  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.96.0"
    }
  }
}