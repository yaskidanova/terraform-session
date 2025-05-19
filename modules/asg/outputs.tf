output "asg_name" {
  description = "Auto scaling group name"
  value = aws_autoscaling_group.ec2_asg.name
}

output "launch_template_id" {
  description = "Launch template id"
  value = aws_launch_template.ec2_launch_template.id
}

output "security_group_id" {
  description = "EC2 Security group id"
  value = aws_security_group.ec2_lt_sg.id
}
