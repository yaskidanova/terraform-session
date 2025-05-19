resource "aws_security_group" "main" {
  name        = var.name
  description = var.description
}



resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  count             = length(var.ingress_ports)
  security_group_id = aws_security_group.main.id
  cidr_ipv4         = element(var.ingress_cidr, count.index)
  from_port         = element(var.ingress_ports, count.index)
  ip_protocol       = "tcp"
  to_port           = element(var.ingress_ports, count.index)
}


# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
#   security_group_id = aws_security_group.first_ec2.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }
