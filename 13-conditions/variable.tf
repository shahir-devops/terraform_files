
variable "create_bucket" {
    description = "set to true for create the s3 buckets"
    type = bool
    default = true
}
variable "type" {
  default = "t2.nano"
  type = string
}
variable "ami"{
    default = "ami-051a31ab2f4d498f5"
    type = string
}
