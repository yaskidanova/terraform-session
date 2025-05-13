# resource "aws_acm_certificate" "acm_certificate" {
#   domain_name       = "heyimiana.com"
#   validation_method = "DNS"

#   tags = merge(
#     local.common_tags,
#     {Name = replace(local.name, "rtype", "acm_certificate")}
#   )

#   lifecycle {
#     create_before_destroy = true
#   }
# }


# resource "aws_acm_certificate_validation" "acm_validation" {
#   certificate_arn = aws_acm_certificate.acm_certificate.arn
# }