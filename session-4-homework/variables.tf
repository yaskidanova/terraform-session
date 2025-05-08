variable "instance_type" {
  description = "aws instance size or type"
  type        = string // string, number. boolean, list, map
  default     = "t2.micro"
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "ingress_ports" {
  description = "a list of ingress ports"
  type        = list(number)
  default     = [22, 80]

}

variable "ingress_cidr" {
  description = "a list of cidr"
  type        = list(string)
  default     = ["10.0.0.0/16", "0.0.0.0/0", "0.0.0.0/0", "10.0.0.0/16"]

}

variable "public_subnets_cidrs" {
  type = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidrs" {
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}

variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
