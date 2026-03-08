resource "aws_instance" "import" {
  ami           = "ami-051a31ab2f4d498f5"
  instance_type = "t2.micro"
  key_name      = "shahir"
  tags = {
    Name = "demo"
  }
}

/*
import is used to bring existing infrastructure (already created outside the terraform)
into terraform state so terraform can manage it.
*/

