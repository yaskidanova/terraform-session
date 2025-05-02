terraform {
  required_version = "~>1.11.0"        #Terraform version  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.96.0"
    }
  }
}

// ~> = Lazy Constraints 
// Semantic versioning = 1.11.4
// 1 = major (upgrate) = breaking changes 
// 11 = manor (update) = features 
// 4 = patch (patch) = fix bugs, vulnarabilities 

// "~>1.11.0"    =   ">=1.11.0, <1.12.0" 