data "aws_ami" "amazonami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "name" {
  ami           = data.aws_ami.amazonami.id
  instance_type = "t2.micro"
  key_name      = "shahir"
}