resource "aws_instance" "first_ec2" {
  ami           = "ami-07b0c09aab6e66ee9"       # argument 
  instance_type = "t2.micro"
  tags = {
    Name        = "my-terraform-webserver"
    Environment = "dev"
  }
  user_data = "${file("install_apache.sh")}"
  vpc_security_group_ids = [aws_security_group.simple_sg.id]
    }
resource "aws_security_group" "simple_sg" {
  
  name = "simple-sg"
  description = "this is a test security group"
  
  ingress {
    from_port        = 80           // number  does not use ""
    to_port          = 80
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




# Interpolation
# Block and Argument 
# 2 main blocks: resource vs data source
# Resource block - create and manage resources  
# Resource block has 2 labels: first_label and second_label 
# FIRST_LABEL = indicates a resourse you want to create or manage, defined by Hashicorp
# SECOND_LABEL = indicates a Logical name or Logical ID for your Terraform resource, needs to be unique wihtin your working directory, define by Author. BE LOGICAL
# Argument - configuration of your resource, key = value

# Argument reference
# Atributes are known after creating a resource