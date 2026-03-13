resource "aws_instance" "demo" {
  ami                    = "ami-051a31ab2f4d498f5"
  instance_type          = "t2.micro"
  key_name               = "shahir"
}

resource "aws_security_group" "devops_security" {
  name = "devops_sec"
  description = "security group for ec2"

  ingress = [
    for port in [22,80,443,8080,9000,3000,8082,8081]:{
        description = "inbound rules"
        from_port = port
        to_port = port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
    }
  ]
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]  
    }
    tags = {
        Name = "devops_sec"
    }
} 