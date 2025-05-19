variable "aws_route53_zone_id" {
  type = string
  description = "Route53 zone ID"
}

variable "aws_route53_record_name" {
  type = string 
  description = "Route53 zone name"
}

variable "record_type" {
  type = string
  description = "Route53 record type"
}

variable "target_dns_name" {
  type = string 
  description = "LB dns name"
}

variable "lb_zone_id" {
  type = string
  description = "LB zone ID"
}

variable "evaluate_target_health" {
  type        = bool
  description = "Whether to evaluate the health of the target resource."
  default     = true
}
