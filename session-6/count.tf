resource "aws_sqs_queue" "count_queue" {
  count = length(var.names)
  name = element(var.names, count.index)
}

variable "names" {
  type = list(string)
  description = "A list of sqs names"
  default = [ "first", "second", "third" ]
}

// this code block will create 3 aws sqs. The name are first, second, third 
// element function is limited to a list 
// untill terraform 0.13 we used element

// problem statement: what if i have a map

