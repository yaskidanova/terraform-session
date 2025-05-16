terraform {
  backend "s3" {
    bucket  = "terraform-session-backend-bucket-iana"
    key     = "terraform.tfstate" // where you would like to store your file 
    region  = "us-west-2"
    encrypt = true
    workspace_key_prefix = "workspaces"
  }
}
