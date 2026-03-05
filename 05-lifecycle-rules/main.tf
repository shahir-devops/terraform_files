resource "aws_instance" "ec2_user" {
    ami           = "ami-051a31ab2f4d498f5"
  instance_type = "t2.micro"
  key_name      = "shahir"
  tags = {
    Name = "lifecycle"
  }
  count = 3
  lifecycle {
    create_before_destroy = true #this attribute will create the new object first and then destroy the old one 
  }
  /*
  below are the lifecycle arguments 

  lifecycle {
    prevent_destroy = true # terraform will get error when it attempts to destory a resource when this is set to true:
  }
  lifecycle {
    ignore_changes = [ tags. ] #this means that terraform will never update the object but will be able to create or destory it.
  }
*/
}