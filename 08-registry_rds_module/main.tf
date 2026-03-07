module "db" {
  source = "terraform-aws-modules/rds/aws" 

  identifier = "demodb" #The name of the RDS instance

  engine            = "mysql" #The database engine to use
  engine_version    = "8.0" #The engine version to use
  instance_class    = "db.t3a.large" #The instance type of the RDS instance
  allocated_storage = 5  #The allocated storage in gigabytes

  db_name  = "demodb" #The DB name to create. If omitted, no database is created initially
  username = "user" #Username for the master DB user
  port     = "3306" #The port on which the DB accepts connections

  iam_database_authentication_enabled = true #Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled.

  vpc_security_group_ids = ["sg-12345678"] #List of VPC security groups to associate

  maintenance_window = "Mon:00:00-Mon:03:00" #The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00
  backup_window      = "03:00-06:00" #The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window.

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = "30" #The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60.
  monitoring_role_name   = "MyRDSMonitoringRole" #Name of the IAM role which will be created when create_monitoring_role is enabled.
  create_monitoring_role = true #Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs.

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  create_db_subnet_group = true #Whether to create a database subnet group
  subnet_ids             = ["subnet-12345678", "subnet-87654321"]  #A list of VPC subnet IDs

  # DB parameter group
  family = "mysql8.0" 

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  deletion_protection = true

  parameters = [   #A list of DB parameters (map) to apply
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [  #A list of Options to apply
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}