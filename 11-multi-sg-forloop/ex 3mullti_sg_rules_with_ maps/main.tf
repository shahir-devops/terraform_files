variable "ports" {
    type = map(string)
    default = {
      22 = "10.0.0.0/24",
      80 = "0.0.0.0/0"
      443 = "172.32.0.0/24"
      8080 = "0.0.0.0/0"
      }
}
resource "aws_security_group" "name" {
  name = "devops_sec"
  description = "security groups"
  
  dynamic "ingress" {
    for_each = var.ports
    content {
      description = "ports ${ingress.key}"
      from_port = ingress.key
      to_port = ingress.key
      protocol = "tcp"
      cidr_blocks = [ingress.value]

    }
  }
  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_block = "[0.0.0.0/0]"

  }
}