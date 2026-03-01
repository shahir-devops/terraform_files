output "publicip" {
  value = aws_instance.demo.public_ip
}

output "privateIp" {
  value = aws_instance.demo.private_ip
}
