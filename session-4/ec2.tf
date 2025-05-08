resource "aws_instance" "first_ec2" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type
  tags = {
    Name  = "${var.env}-instance"
    Name2 = format("%s-instance", var.env)
  }
  vpc_security_group_ids = [aws_security_group.first_ec2.id]
  user_data              = templatefile("user_data.sh", { environment = var.env })
}

// with count meta argument each second label gets indexed (unique)


resource "aws_security_group" "first_ec2" {
  name        = "${var.env}-instance-sg"
  description = "this is a test security group"
}

# resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
#   count = length(var.ingress_ports)
#   security_group_id = aws_security_group.first_ec2.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = var.ingress_ports[count.index]
#   ip_protocol       = "tcp"
#   to_port           = var.ingress_ports[count.index]
# }

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  count             = length(var.ingress_ports)
  security_group_id = aws_security_group.first_ec2.id
  cidr_ipv4         = element(var.ingress_cidr, count.index)
  from_port         = element(var.ingress_ports, count.index)
  ip_protocol       = "tcp"
  to_port           = element(var.ingress_ports, count.index)
}
// syntax: element (list,index)
// element ([45, 76, 23, 14, 57, 15], 4)

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.first_ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

