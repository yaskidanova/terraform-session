
variable "env" {
  description = "Environment"
  type        = string
  default     = "dev"
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
  default     = "tom"
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
  default     = "kris"
}

variable "managed_by" {
  description = "Tool"
  type        = string
  default     = "terraform"
}