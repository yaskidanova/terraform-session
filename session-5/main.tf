# resource "aws_sqs_queue" "main" {
#   name = local.name
#   tags = local.common_tags
# }


resource "aws_sqs_queue" "main" {
  name = replace(local.name, "rtype", "sqs")
  tags = merge(
    local.common_tags,
    {Name = replace(local.name, "rtype", "sqs")}
  )
}

resource "aws_db_instance" "main" {
  allocated_storage    = 10
  identifier = replace(local.name, "rtype", "rds")      //rds instance name 
  db_name              = "wordpress"                    // db name 
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = random_password.password.result
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = var.env != "prod" ? true : false
  final_snapshot_identifier = var.env != "prod" ? null : "${var.env}-final_snapshot" 
}


resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

output "main_db_password" {
    value = random_password.password.result
    sensitive = true
}



// skip_final_snaphsot = true = there will not be snapshot 

// Problem statement: i want a snapshot only on prod environment but not on dev, qa 
