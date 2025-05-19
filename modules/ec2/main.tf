resource "aws_instance" "first_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name  = "${var.env}-instance"
    Name2 = format("%s-instance", var.env)
  }
  vpc_security_group_ids = var.vpc_security_group_ids
}