output "security_group_id" {
  description = "ALB security groupID "
  value       = aws_security_group.alb_sg.id
}

output "target_group_arn_id" {
  description = "The ARN of the target group created by the ALB module"
  value       = aws_lb_target_group.alb_ec2_tg.arn
}

output "alb_security_group_id" {
  description = "The ID of the security group created for the ALB"
  value       = aws_security_group.alb_sg.id
}

output "lb_name" {
  description = "The name of the load balancer"
  value = aws_lb.app_lb.name
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value = aws_lb.app_lb.dns_name
}

output "lb_zone_id" {
  description = "The ID of the hosted zone associated with the load balancer"
  value       = aws_lb.app_lb.zone_id
}

