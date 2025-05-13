// create a security group for ALB

resource "aws_security_group" "alb_sg" {
  name = "alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id = aws_vpc.app_vpc1.id
  tags = merge(
    local.common_tags,
    {Name = replace(local.name, "rtype", "alb_sg")}
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  count             = length(var.ingress_ports_alb)
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.ingress_ports_alb[count.index]
  ip_protocol       = "tcp"
  to_port           = var.ingress_ports_alb[count.index]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

// create ALB

resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public_subnet[*].id
  tags = merge(
    local.common_tags,
    {Name = replace(local.name, "rtype", "lb")}
  )
}

//create a target group for ALB

resource "aws_lb_target_group" "alb_ec2_tg" {
  name     = "alb-tg"
  port     = var.ingress_ports_alb[0]
  protocol = "HTTP"
  vpc_id   = aws_vpc.app_vpc1.id
  tags = merge(
    local.common_tags,
    {Name = replace(local.name, "rtype", "alb_ec2_tg")}
  )
}

// create a listener 


resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port = var.ingress_ports_alb[0]
  protocol = "HTTP"
  
  default_action {
    type = "redirect"
    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
    target_group_arn = aws_lb_target_group.alb_ec2_tg.arn
  }
  
  tags = merge(
    local.common_tags,
    {Name = replace(local.name, "rtype", "alb_listener")}
  )
}

resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port = var.ingress_ports_alb[1]
  protocol = "HTTPS"
  certificate_arn = data.aws_acm_certificate.issued.arn
  
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_ec2_tg.arn
  }

  tags = merge(
    local.common_tags,
    {Name = replace(local.name, "rtype", "alb_listener")}
  )
}

# certificate_arn = data.aws_acm_certificate.issued.arn