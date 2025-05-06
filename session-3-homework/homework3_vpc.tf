// create a vpc

resource "aws_vpc" "app-vpc1" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "terraform-vpc1"
    }
}

// create a public subnet - I need 3 

resource "aws_subnet" "app-public-subnet-1" {
    vpc_id = aws_vpc.app-vpc1.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
}

resource "aws_subnet" "app-public-subnet-2" {
    vpc_id = aws_vpc.app-vpc1.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
}

resource "aws_subnet" "app-public-subnet-3" {
    vpc_id = aws_vpc.app-vpc1.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1c"
}

// create a private subnet - I need 3 

resource "aws_subnet" "app-private-subnet-1" {
    vpc_id = aws_vpc.app-vpc1.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1a"
}

resource "aws_subnet" "app-private-subnet-2" {
    vpc_id = aws_vpc.app-vpc1.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"
}

resource "aws_subnet" "app-private-subnet-3" {
    vpc_id = aws_vpc.app-vpc1.id
    cidr_block = "10.0.5.0/24"
    availability_zone = "us-east-1c"
}

// create an IGW

resource "aws_internet_gateway" "app-igw1" {
    vpc_id = aws_vpc.app-vpc1.id
}

// create a public route table with route 

resource "aws_route_table" "app-public-rt1" {
    vpc_id = aws_vpc.app-vpc1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.app-igw1.id
    }
}

// create a private route table with route

resource "aws_route_table" "app-private-rt1" {
    vpc_id = aws_vpc.app-vpc1.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.app-natgateway1.id
    }
}
// I need to associate public subnets with a public route table

resource "aws_route_table_association" "public-rt1-association-sub-1" {
    subnet_id = aws_subnet.app-public-subnet-1.id
    route_table_id = aws_route_table.app-public-rt1.id
}

resource "aws_route_table_association" "public-rt1-association-sub-2" {
    subnet_id = aws_subnet.app-public-subnet-2.id
    route_table_id = aws_route_table.app-public-rt1.id
}

resource "aws_route_table_association" "public-rt1-association-sub-3" {
    subnet_id = aws_subnet.app-public-subnet-3.id
    route_table_id = aws_route_table.app-public-rt1.id
}

// I need to associate private subnets with a private route table 

resource "aws_route_table_association" "private-rt1-association-sub-1" {
    subnet_id = aws_subnet.app-private-subnet-1.id
    route_table_id = aws_route_table.app-private-rt1.id
}

resource "aws_route_table_association" "private-rt1-association-sub-2" {
    subnet_id = aws_subnet.app-private-subnet-2.id
    route_table_id = aws_route_table.app-private-rt1.id
}

resource "aws_route_table_association" "private-rt1-association-sub-3" {
    subnet_id = aws_subnet.app-private-subnet-3.id
    route_table_id = aws_route_table.app-private-rt1.id
}

// we can not launch NAT Gateway without an Elastic IP address so we need to create an Elastic IP

resource "aws_eip" "elastic-ip" {
    domain = "vpc" 
}
// create a NAT Gateway

resource "aws_nat_gateway" "app-natgateway1" {
    allocation_id = aws_eip.elastic-ip.id
    subnet_id = aws_subnet.app-public-subnet-1.id
}

// create an EC2 Instance

resource "aws_instance" "app_ec2" {
  ami           = "ami-0f88e80871fd81e91"       # argument 
  instance_type = var.instance_type
  subnet_id = aws_subnet.app-public-subnet-1.id
  tags = {
    Name = "${var.env}-instance"      // dev-instance, qa-instance, prod-instance
    Environment = var.env
  }
  vpc_security_group_ids = [aws_security_group.app_ec2.id] // anything dynamic goes wihtout ""
}

// create a security group , port 80, 22 open

resource "aws_security_group" "app_ec2" {
  
  name = "session3-homework-sg"
  description = "this is a security group for my homework"
  vpc_id = aws_vpc.app-vpc1.id
  
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