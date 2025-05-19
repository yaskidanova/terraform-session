output "vpc_id" {
  value       = aws_vpc.app_vpc1.id
  description = "VPC ID "
}

output "public_subnet_ids" {
  value       = aws_subnet.public_subnet[*].id
  description = "List of IDs for the public subnets"
}

output "private_subnet_ids" {
  value       = aws_subnet.private_subnet[*].id
  description = "List of IDs for the private subnets"
}