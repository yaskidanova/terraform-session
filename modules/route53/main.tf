resource "aws_route53_record" "www" {
  zone_id = var.aws_route53_zone_id
  name = var.aws_route53_record_name
  type = var.record_type

  alias {
    name = var.target_dns_name
    zone_id = var.lb_zone_id
    evaluate_target_health = var.evaluate_target_health
  }
}