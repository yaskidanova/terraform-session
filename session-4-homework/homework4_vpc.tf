// create a vpc

resource "aws_vpc" "app-vpc1" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "terraform-vpc1"
    }
}

// create a public subnet - I need 3 

resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnets_cidrs)
    vpc_id = aws_vpc.app-vpc1.id
    cidr_block = element(var.public_subnets_cidrs, count.index)
    availability_zone = element(var.availability_zones, count.index)
    tags = {
        Name = "public_subnet_${count.index + 1}"
    }
}

// create a private subnet - I need 3 

resource "aws_subnet" "private_subnet" {
    count = length(var.private_subnets_cidrs)
    vpc_id = aws_vpc.app-vpc1.id
    cidr_block = element(var.private_subnets_cidrs, count.index)
    availability_zone = element(var.availability_zones, count.index)
    tags = {
        Name = "private_subnet_${count.index + 1}"
    }
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

resource "aws_route_table_association" "public" {
    count = length(var.public_subnets_cidrs)
    subnet_id = aws_subnet.public_subnet[count.index].id
    route_table_id = aws_route_table.app-public-rt1.id
}


// I need to associate private subnets with a private route table 

resource "aws_route_table_association" "private" {
    count = length(var.private_subnets_cidrs)
    subnet_id = aws_subnet.private_subnet[count.index].id
    route_table_id = aws_route_table.app-private-rt1.id
}


// we can not launch NAT Gateway without an Elastic IP address so we need to create an Elastic IP

resource "aws_eip" "elastic-ip" {
    domain = "vpc" 
}

// create a NAT Gateway

resource "aws_nat_gateway" "app-natgateway1" {
    allocation_id = aws_eip.elastic-ip.id
    subnet_id = aws_subnet.public_subnet[0].id
}

// create an EC2 Instance

resource "aws_instance" "app_ec2" {
  ami           = data.aws_ami.amazon_linux_2023.id       
  instance_type = var.instance_type
  subnet_id = aws_subnet.public_subnet[0].id
  tags = {
    Name = "${var.env}-instance"      
    Environment = var.env
  }
  vpc_security_group_ids = [aws_security_group.app_sg.id] 
}

// create a security group , port 80, 22 open

resource "aws_security_group" "app_sg" {
  name        = "${var.env}-instance-sg"
  description = "this is a test security group"
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  count = length(var.ingress_ports)
  security_group_id = aws_security_group.app_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = var.ingress_ports[count.index]
  ip_protocol       = "tcp"
  to_port           = var.ingress_ports[count.index]
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.app_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}