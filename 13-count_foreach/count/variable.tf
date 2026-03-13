variable "amiid" {
  default = "ami-051a31ab2f4d498f5"
  type = string
}
variable "type" {
    default = "t2.micro"
    type = string
}

variable "env" {
  type = list(string)
  default = [ "dev", "prod", "test" ]
}

variable "users" {
    type = list(string)
    default = [ "shahir", "syed", "ram", "raheem" ]
}
