resource "aws_instance" "demo" {
  ami           = "ami-051a31ab2f4d498f5"
  instance_type = "t2.micro"
  key_name      = "shahir"
}

resource "aws_s3_bucket" "name" {
  bucket = "shahir143mithundevops"
}
