variable "env" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "ami_id" {
  type    = string
  default = "ami-04999cd8f2624f834"
}

variable "certificate_arn" {
  description = "ARN of the ACM certifiate"
  type        = string
  default     = "arn:aws:acm:us-west-2:752601836544:certificate/767dc524-53cc-4792-8000-26e656693962"
}

variable "aws_route53_zone_id" {
  type = string
  default = "Z04579721MBMF311OW5UC"
}

/// tags ///

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