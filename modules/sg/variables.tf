

variable "name" {
  description = "Environment"
  type        = string
  default     = "test-sg"
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
