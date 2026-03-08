data "aws_subnet" "subnet_id" {
  filter {
    name   = "tag:Name"
    values = ["subnet-1a"]
  }
}

data "aws_security_groups" "secgrps" {
  filter {
    name   = "tag:Name"
    values = ["test"]
  }
}

resource "aws_instance" "this" {
  ami             = "ami-051a31ab2f4d498f5"
  instance_type   = "t2.micro"
  key_name        = "shahir"
  subnet_id       = data.aws_subnet.subnet_id.id
  security_groups = [data.aws_security_groups.secgrps.ids[0]]
}