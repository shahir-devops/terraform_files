resource "aws_db_instance" "mysqldb" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.4.7"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "Cloud123"
  parameter_group_name = "default.mysql8.4"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.sub_grp.name
}

resource "aws_db_subnet_group" "sub_grp" {
  name = "main"
  subnet_ids = ["subnet-05e6b9d5eeba6b0e9",
  "subnet-0cd44f22f73f37f72"] #subnet id will be in different az required in same region 
  tags = {
    Name = "My DB subnet group"
  }
}
