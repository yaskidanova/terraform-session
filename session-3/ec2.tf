resource "aws_instance" "first_ec2" {
  count         = 5                                 // metaargument 
  ami           = data.aws_ami.amazon_linux_2023.id # argument 
  instance_type = var.instance_type
  tags = {
    Name        = "${var.env}-instance"          // dev-instance, qa-instance, prod-instance
    Name2       = format("%s-instance", var.env) // dev-instance
    Environment = var.env
  }
  vpc_security_group_ids = [aws_security_group.first_ec2.id]                       // anything dynamic goes wihtout ""
  user_data              = templatefile("user_data.sh", { environment = var.env }) // datasource renders
}


// reference to resourse 
// syntax: first_lable.second_label.attribute 
// example: aws_security_group.first_ec2.id

// reference to input variable 
// syntax: var.variable_name
// example: var.instance_type

// reference to data_source
// syntax: data.first_label.second_label.attribute
// example: data.aws_ami.amazon_linux_2023.id

resource "aws_security_group" "first_ec2" {

  name        = "session3-sg"
  description = "this is a test security group"

  ingress {
    from_port   = 80 // number  does not use ""
    to_port     = 80
    protocol    = "tcp"         // everything inside "" is a string 
    cidr_blocks = ["0.0.0.0/0"] // list of string 


  }
  ingress {
    from_port   = 22 // number  does not use ""
    to_port     = 22
    protocol    = "tcp"         // everything inside "" is a string 
    cidr_blocks = ["0.0.0.0/0"] // list of string 


  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" //tcp, udp, icmp
    cidr_blocks = ["0.0.0.0/0"]

  }
}