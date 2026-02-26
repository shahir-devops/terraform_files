terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  profile = "terraformprofile"
}
provider "aws" {
  region = "ap-south-2"
  profile = "terraformprofile"
  alias = "hyderabad"
}
/*
data "aws_ami" "redhatlat"{
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["RHEL-9.4.0_HVM-20250917-x86_64-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


resource "aws_iam_user" "userbucket" {
  for_each = toset(["syed", "shaik", "patan"])
  name = each.key
  tags={
    "Name" = each.key
  }
}

resource "aws_s3_bucket" "mybucket"{
  for_each = {
    "dev" =  "shahirbucket"
    "prod" =  "shahirbucket"
    "qa" =  "shahirbucket"
  }
  bucket= "${each.key}-${each.value}"
  tags = {
    Name = "${each.key}-${each.value}"
    Environment = "${each.value}"
    ManagedBy = "Terraform"
  }
}
*/


resource "aws_instance" "web"{
  ami = "ami-001ce22601d4c605f"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  count = 1
  tags={
    "Name"= "AppServer"
  }
  lifecycle {
    create_before_destroy = true
    prevent_destroy = true
  }
}

/*
resource "aws_instance" "hyb"{
  ami = "ami-038d851361e6d0e02"
  instance_type = "t3.micro"
  availability_zone = "ap-south-2a"
  count = 1
  provider = aws.hyderabad
  tags={
    "Name"= "Hyderabad"
  }
}
*/
