/*In Terraform, null_resource is used when you want to run scripts or commands that are not directly creating infrastructure. 
It is often used with provisioners like:
local-exec
remote-exec
file

Sometimes you want to run only one resource.

Example:

terraform apply -target=null_resource.provisioner_example

This will run only the null resource, not the entire infrastructure.

ex: terraform apply -target=aws_instance.example
*/

resource "aws_instance" "demo" {
  ami                    = "ami-051a31ab2f4d498f5"
  instance_type          = "t2.micro"
  key_name               = "shahir"
}

resource "null_resource" "examples" {
  depends_on = [ aws_instance.demo ]

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("shahir.pem")
    host = aws_instance.demo.public_ip
  }
  #FILE provisioner (copy file to server)
  provisioner "file" {
    source = "script.sh"
    destination = "/home/ec2-user/script.sh"
  }
  #REMOTE EXEC (run commands on server)
  provisioner "remote-exec" {
    inline = [ 
        "chmod +x /home/ec2-user/script.sh", 
        "/home/ec2-user/script.sh" 
        ]
  }
  #LOCAL EXEC (run command on local machine)
  provisioner "local-exec" {
    command = "echo instance created with IP ${aws_instance.demo.public_ip}"
  }
    # Trigger to rerun if instance changes
  triggers = {
    instance_id =aws_instance.demo
  }

}
#null_resource WITHOUT dependency
resource "null_resource" "example" {

  provisioner "local-exec" {
    command = "echo Running null resource"
  }

}
