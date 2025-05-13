// fetch Amazon Linux 2023 AMI ID 
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.7.*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
#   data "template_file" "user_data" {
#   template = file("user_data.sh")
#     vars = {
#     environment = var.env  
#     # variable in bash = variable in terraform
#     }
#   }

data "aws_route53_zone" "existing_zone" {
  name = "heyimiana.com"
  private_zone = false
}

data "aws_acm_certificate" "issued" {
  domain = "heyimiana.com"
  statuses = ["ISSUED"]
  most_recent = true 
}