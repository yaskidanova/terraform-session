variable "instance_type" {
    description = "aws instance size or type"
    type = string                                   // string, number. boolean, list, map
    default = "t2.micro"
}

variable "env" {
    description = "Emvironment"
    type = string
    default = "qa"
}
