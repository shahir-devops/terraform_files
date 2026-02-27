resource "aws_instance" "amiid"{
    ami = var.amiid
    instance_type = var.type
    key_name = var.keyname
}