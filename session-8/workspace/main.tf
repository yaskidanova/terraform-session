resource "aws_sqs_queue" "main" {
  name = "${terraform.workspace}-sqs"

}

// terraform workspace show (current workspace)

// how to reference to workspace: terraform.workspace
// terraform.workspace = current workspace name 

// in s3 bucket
// syntax : workspace_key_prefix/workspace_name/key
// example : workspaces