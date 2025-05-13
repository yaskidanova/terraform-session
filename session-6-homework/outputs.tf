output "vpc_id" {
  value       = aws_vpc.app_vpc1.id
  description = "VPC ID "
}

output "public_subnet_ids" {
  value       = [aws_subnet.public_subnet[*].id]
  description = "List of IDs for the public subnets"
}

output "private_subnet_ids" {
  value       = [aws_subnet.private_subnet[*].id]
  description = "List of IDs for the private subnets"
}

output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.ec2_launch_template.id
}

output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}