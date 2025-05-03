resource "aws_instance" "first_ec2" {
  ami           = "ami-07b0c09aab6e66ee9"       # argument 
  instance_type = var.instance_type
  tags = {
    Name = "${var.env}-instance"      // dev-instance, qa-instance, prod-instance
    Name2 = format("%s-instance", var.env)  // dev-instance
    Environment = var.env
  }
  vpc_security_group_ids = [aws_security_group.first_ec2.id] // anything dynamic goes wihtout ""
}

// reference to resourse 
// syntax: first_lable.second_label.attribute 
// example: aws_security_group.first_ec2.id

// reference to input variable 
// syntax: var.variable_name
// example: var.instance_type

resource "aws_security_group" "first_ec2" {
  
  name = "session3-sg"
  description = "this is a test security group"
  
  ingress {
    from_port        = 80           // number  does not use ""
    to_port          = 80
    protocol         = "tcp"        // everything inside "" is a string 
    cidr_blocks      = ["0.0.0.0/0"]  // list of string 
    

  }
  ingress {
    from_port        = 22           // number  does not use ""
    to_port          = 22
    protocol         = "tcp"        // everything inside "" is a string 
    cidr_blocks      = ["0.0.0.0/0"]  // list of string 
    

  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"     //tcp, udp, icmp
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
}