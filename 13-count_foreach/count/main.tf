# resource "aws_instance" "dev" {
#   ami = var.amiid
#   instance_type = var.type
#   key_name = "shahir"
#   count = length(var.env)
#   tags = {
#     Name = var.env[count.index]
#   }
# }


resource "aws_iam_user" "aws_user"{
  count = length(var.users)
  name = var.users[count.index]
}