resource "aws_instance" "demo" {
  ami                    = "ami-051a31ab2f4d498f5"
  instance_type          = "t2.micro"
  key_name               = "shahir"
  subnet_id              = aws_subnet.sub1.id
  vpc_security_group_ids = [aws_security_group.sec_tls.id]
  tags = {
    Name = "vpc-create"
  }
}