terraform {
  backend "s3" {
    bucket         = "terraform-session-backend-bucket-iana"
    key            = "session-4/terraform.tfstate" // where you would like to store your file 
    region         = "us-west-2"
    encrypt        = true
  }
}
