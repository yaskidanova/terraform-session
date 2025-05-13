variable "instance_type" {
  description = "aws instance size or type"
  type        = string // string, number. boolean, list, map
  default     = "t2.micro"
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "cidr_block" {
  description = "CIDR block"
  type = string
  default = "10.0.0.0/16"
}

variable "ingress_ports_alb" {
  description = "a list of ingress ports for alb"
  type        = list(number)
  default     = [80, 443]
}

variable "ingress_ports_ec2" {
  description = "a list of ingress ports for ec2"
  type        = list(number)
  default     = [22, 80]
}

variable "ingress_cidr" {
  description = "a list of cidr"
  type        = list(string)
  default     = ["10.0.0.0/16", "0.0.0.0/0", "0.0.0.0/0", "10.0.0.0/16"]

}

variable "public_subnets_cidrs" {
  type    = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidrs" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}

variable "availability_zones" {
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}




variable "provider_name" {
  description = "Provider"
  type        = string
  default     = "aws"
}

variable "business_unit" {
  description = "Provider"
  type        = string
  default     = "orders"
}

variable "region" {
  description = "Provider region name"
  type        = string
  default     = "usw2"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "olala"
}

variable "tier" {
  description = "Application tier"
  type        = string
  default     = "db"
}

variable "team" {
  description = "Team name"
  type        = string
  default     = "DevOps"
}

variable "owner" {
  description = "Resource owner"
  type        = string
  default     = "iana"
}

variable "managed_by" {
  description = "Tool"
  type        = string
  default     = "terraform"
}