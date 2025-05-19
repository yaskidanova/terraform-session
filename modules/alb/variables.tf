variable "env" {
  description = "Environment"
  type        = string
  default     = "dev"
}


variable "ingress_ports_alb" {
  description = "a list of ingress ports for alb"
  type        = list(number)
  default     = [80, 443]
}

variable "vpc_id" {
  type = string
}

variable "certificate_arn" {
  type = string
  default = "arn:aws:acm:us-west-2:752601836544:certificate/767dc524-53cc-4792-8000-26e656693962"
}

variable "alb_tg_name" {
  type = string
  default = "alb-tg"
}

variable "lb_name" {
  type = string
  default = "app-lb"
}

variable "public_subnets" {
  type = list(string)
  
}

variable "tags" {
  type = map(string)
}

//// tags ////
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