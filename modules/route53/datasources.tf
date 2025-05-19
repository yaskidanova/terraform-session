data "aws_route53_zone" "existing_zone" {
  name = "heyimiana.com"
  private_zone = false
}

data "aws_acm_certificate" "issued" {
  domain = "heyimiana.com"
  statuses = ["ISSUED"]
  most_recent = true 
}