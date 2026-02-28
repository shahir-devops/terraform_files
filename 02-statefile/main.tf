resource "aws_instance" "demo"{
    ami = "ami-051a31ab2f4d498f5"
    instance_type = "t2.micro"
    key_name = "shahir"
}

# terraform statefile will track the resource information and responsible to manage desired state to current state

/*
desired state (local code where we write in laptop ) ---> terraform apply ( it goes to aws and create resources and store the resource data in terraform statefile)
when 2nd another time --->terraform apply --> it goes to change/modify/delete the terrform statefile is there any update it will  
otherwise dont go to aws

when some change manually in aws it doesnt reflect in desired file, ex:- change manually security group in aws account,
no changes in desired file(terraform plan, apply ) because we doesnt use security group in main.tf

only when there is change in desired file and when we use that in main.tf it will work 
for change availabiity zone it will delete and create the file 
for change instance type stop and start the server

it dont have any access to stop and start the server to terraform
*/



