# variable "aws_region" {
#     description = "the region in which to create the infrastructure"
#     type = string
#     default = "ap-south-1"
#     validation {
#     condition = var.aws_region == "us-west-2" || var.aws_region == "ap-south-1"
#     error_message = "the variable 'aws_region' must be one of the following region: us-west-2, ap-south-1"
#     }
# }
# resource "aws_instance" "ec2" {
#   ami = "ami-051a31ab2f4d498f5"
#   instance_type = "t2.micro"
#   key_name = "shahir"
  
# }


resource "aws_s3_bucket" "bucket" {
  count = var.create_bucket ? 1 :0 
  bucket = "sdcsdfjcsbc"
  
  tags = {
    Name = "conditionalbucket"
    environment = "Dev"
  }
}


resource "aws_instance" "dev" {
  ami =var.ami
  instance_type = var.type
  count = var.type == "t2.micro" ? 1 : 0

  tags = {
    Name = "dev_server"
  }
}