resource "aws_launch_template" "ec2_launch_template" {
  name = "web-server"
  image_id = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = false
    subnet_id = aws_subnet.private_subnet[0].id
    security_groups = [ aws_security_group.ec2_lt_sg.id ]
  }
  user_data = base64encode(file("user_data.sh"))

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
  name = "ec2-sg"
  description = "Security group for EC2 Instance"
  vpc_id = aws_vpc.app_vpc1.id
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
  referenced_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.ec2_lt_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}
