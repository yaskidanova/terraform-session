# Naming convention: naming standard 

# 1. Provider name: aws, azure gcp, digital ocean 
# 2. Region: usw1, usw2, use1
# 3. Resource type: s3, ec2, efs
# 4. Environment: dev, qa, stg, prod 
# 5. Business unit: payment, streaming, orders
# 6. Project name: unicorn, batman, ihop, tom
# 7. Tier: frontend, backend, db 

# Example1: aws-usw2-vpc-orders-tom-db-dev


# Tagging convention: tagging standard (common tags)

# 1. Envirinment: dev, qa, stg 
# 2. Project name: unicorn, batman, tom, jerry 
# 3. Business unit: streaming 
# 4. Team: DevOps, DRE, SRE 
# 5. Owner: mail@mail.com 
# 6. Manged by: terraform, python
# 7. Market; na, asia, 



locals {
  name = "${var.provider_name}-${var.region}-rtype-${var.business_unit}-${var.tier}-${var.project}"
  common_tags = {
    Environment   = var.env
    Project_name  = var.project
    Business_unit = var.business_unit
    Team          = var.team
    Owner         = var.owner
    Managed_by    = var.managed_by
    Market        = "us"
  }
}