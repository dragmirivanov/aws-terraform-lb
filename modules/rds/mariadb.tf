resource "aws_db_instance" "rds" {
    allocated_storage = 20
    identifier = "endavadb"
    storage_type = "gp2"
    engine = "mariadb"
    engine_version = "10.6.10"
    instance_class = "db.t2.micro"
    username = var.mariadbuser
    password = var.mariadbpassword
    port = 3306
    publicly_accessible    = true
    skip_final_snapshot = true

  tags = {
    Name = "endava-rds-database"
  }
}
