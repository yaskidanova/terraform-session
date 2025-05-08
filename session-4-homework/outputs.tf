output "aws_instance_public_ip" {
  value       = aws_instance.app_ec2[*].public_ip
  description = "AWS EC2 Instance Public IP address"
}
