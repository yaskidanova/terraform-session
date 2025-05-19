module "vpc" {
  source = "../modules/vpc"

  name       = "my_vpc"
  cidr_block = "10.0.0.0/16"

  availability_zones    = ["us-west-2a", "us-west-2b", "us-west-2c"]
  public_subnets_cidrs  = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidrs = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]


  tags = merge(
    local.common_tags,
    { Name = replace(local.name, "rtype", "vpc") }
  )
}

output "test" {
  value = module.vpc.private_subnet_ids
}

module "asg" {
  source = "../modules/asg"

  min_size              = 1
  max_size              = 2
  desired_capacity      = 2
  health_check_type     = "EC2"
  vpc_zone_identifier   = module.vpc.private_subnet_ids
  target_group_arns      = [module.alb.target_group_arn_id]
  ec2_name              = "my_ec2"
  alb_security_group_id = module.alb.alb_security_group_id
  asg_name              = "my_asg"
  vpc_id                = module.vpc.vpc_id
  user_data             = filebase64("user_data.sh")
  ami_id                = var.ami_id


  tags = merge(
    local.common_tags,
    { Name = replace(local.name, "rtype", "asg") }
  )

}

module "alb" {
  source = "../modules/alb"

  lb_name    = "my-alb"
  vpc_id  = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnet_ids
  ingress_ports_alb = [ 80, 443 ]
  certificate_arn = var.certificate_arn

 tags = merge(
    local.common_tags,
    {Name = replace(local.name, "rtype", "alb")}
  )
}


module "zones" {
  source = "../modules/route53"
  aws_route53_zone_id = var.aws_route53_zone_id
  aws_route53_record_name = "www"
  target_dns_name = module.alb.lb_dns_name
  record_type = "A"
  lb_zone_id = module.alb.lb_zone_id

}

