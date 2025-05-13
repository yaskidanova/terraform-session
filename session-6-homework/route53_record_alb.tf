resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.existing_zone.zone_id
  name = "heyimiana.com"
  type = "A"

  alias {
    name = aws_lb.app_lb.dns_name
    zone_id = aws_lb.app_lb.zone_id
    evaluate_target_health = true 
  }
}