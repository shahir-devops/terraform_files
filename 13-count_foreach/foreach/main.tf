resource "aws_instance" "inst" {
  ami = var.amiid
  instance_type = var.type
  for_each = toset(var.env)
  #count =length(var.env)

  tags = {
    Name = each.value # for a set each.value and each.key is the same
  }
}