resource "aws_instance" "demo" {
  ami                    = "ami-051a31ab2f4d498f5"
  instance_type          = "t2.micro"
  key_name               = "shahir"
}

resource "aws_security_group" "devops_security" {
  name = "devops_sec"
  description = "security group for ec2"

  ingress = [
    {
        description = "inbound rules"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    },
    {
        description = "inbound rules"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/0"]
    },{
        description = "inbound rules"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["172.16.0.0/0"]
    },
    {
        description = "inbound rules"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/0"]
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