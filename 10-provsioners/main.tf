/*
In Terraform, a provisioner is used to execute scripts or commands on a local machine or a remote resource 
after the resource is created. It is usually a last resort because Terraform prefers declarative configuration.
Common provisioners:

local-exec – runs command on your local machine

remote-exec – runs command on the remote server (EC2, VM, etc.)

file – copies files from local system to remote server

trigger - re-run provisioner when value changes
*/

resource "aws_instance" "ec2" {
  ami = "ami-051a31ab2f4d498f5"
  instance_type = "t2.micro"
  key_name = "shahir"

  tags = {
    Name = "provisionerDemo"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("shahir.pem")
    host = self.public_ip
  }

  provisioner "file" {
    source = "test.txt"
    destination = "/home/ec2-user/test.txt"
  }

 # REMOTE EXEC PROVISIONER (run commands on EC2)
  provisioner "remote-exec" {
    inline = [ 
        "echo 'Terraform commands' > demo.txt",
        "sudo yum update -y",
        "sudo yum install git -y",
     ]
  }
 # LOCAL EXEC PROVISIONER (run commands on locally)

 provisioner "local-exec" {
   command = "echo ${self.public_ip} >> instance.txt"
 }
}


#Triggers example using null resource

resource "null_resource" "null" {
  triggers = {
    build_version = timestamp()
  }
  provisioner "local-exec" {
    command = " echo 'triggered at ${self.triggers.build_version}'"
  }
}


