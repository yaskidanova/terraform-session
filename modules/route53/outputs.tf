output "route53_record_fqdn" {
  value       = aws_route53_record.www.fqdn             
  description = "The fully qualified domain name of the record."
}