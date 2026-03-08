variable "amiid" {
  default = ""
  type = string
  description = "this is the ami id of the instance"
}

variable "type" {
  default = ""
  type = string
  description = "this is the type of the instance"
}

variable "key" {
  default = ""
  type = string
  description = "used for keypair for the instance"
}
variable "bucketname" {
  default = ""
}