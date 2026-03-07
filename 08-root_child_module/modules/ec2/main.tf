resource "aws_instance" "ec2user" {
    ami = var.amiid
    instance_type = var.type

    tags = {
      Name = "server"
    }
}

