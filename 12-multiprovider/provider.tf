provider "aws" {
    region = "ap-south-1"
    profile = "terraformprofile"
}

provider "aws" {
    region = "us-east-1"
    profile = "terraformprofile"
    alias = "provider2"
}
resource "aws_instance" "ec2" {
  ami = "ami-051a31ab2f4d498f5"
  instance_type = "t2.micro"
  key_name = "shahir"
  provider = aws.provider2
}
