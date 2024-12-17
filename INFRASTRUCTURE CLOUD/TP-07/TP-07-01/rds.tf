# DB Subnet Group for RDS
resource "aws_db_subnet_group" "rds_subnets" {
  name       = "${local.name}-db-subnet-group"
  subnet_ids = aws_subnet.private[*].id
  tags       = { Name = "${local.name}-db-subnet-group" }
}

# RDS Instance
resource "aws_db_instance" "nextcloud_rds" {
  identifier             = "${local.name}-rds"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t4g.micro"
  db_name                = "nextcloud_db"
  username               = "admin"
  password               = random_password.rds_password.result
  multi_az               = true
  storage_type           = "gp2"
  db_subnet_group_name   = aws_db_subnet_group.rds_subnets.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  skip_final_snapshot    = true

  tags = { Name = "${local.name}-rds" }
}
