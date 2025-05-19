variable "instance_type" {
  description = "aws instance size or type"
  type        = string // string, number. boolean, list, map
  default     = "t2.micro"
}

variable "ingress_ports" {
  description = "a list of ingress ports"
  type        = list(number)
  default     = [22, 80, 443, 3306, 23]

}

variable "ingress_cidr" {
  description = "a list of cidr"
  type        = list(string)
  default     = ["10.0.0.0/16", "0.0.0.0/0", "0.0.0.0/0", "10.0.0.0/16"]

}

variable "description" {
  default = "test-sg"
  type = string
  description = "This is description for sg"
}

variable "env" {
  description = "environment"
  type = string
  default = "dev"
}

variable "ami" {
  description = "ami id"
  type = string
  default = "xyz"

}

variable "vpc_security_group_ids" {
  description = "security group id"
  type = list(string)
  default = ["xyz"]
}