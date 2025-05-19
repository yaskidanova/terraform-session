resource "aws_autoscaling_group" "ec2_asg" {
  name = var.asg_name

  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity

  target_group_arns = var.target_group_arns 
  vpc_zone_identifier = var.vpc_zone_identifier

  launch_template {
    id = aws_launch_template.ec2_launch_template.id
    version = "$Latest"
  }
  health_check_type = var.health_check_type

}

resource "aws_launch_template" "ec2_launch_template" {
  name = var.ec2_name
  image_id = var.ami_id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = false
    security_groups = [ aws_security_group.ec2_lt_sg.id ]
  }
  user_data = var.user_data

  tag_specifications {
    resource_type = "instance"
    tags = merge(
    local.common_tags,
    {Name = replace(local.name, "rtype", "ec2_web_server")}
  )
  }
}


// create a security group for ec2

resource "aws_security_group" "ec2_lt_sg" {
  name = var.ec2_name
  description = "Security group for EC2 Instance"
  vpc_id = var.vpc_id
  tags = merge(
    local.common_tags,
    {Name = replace(local.name, "rtype", "ec2_lt_sg")}
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_from_alb" {
  count = length(var.ingress_ports_alb)
  security_group_id = aws_security_group.ec2_lt_sg.id
  from_port         = var.ingress_ports_ec2[count.index]
  ip_protocol       = "tcp"
  to_port           = var.ingress_ports_ec2[count.index]
  referenced_security_group_id = var.alb_security_group_id
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.ec2_lt_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}
