resource "aws_db_instance" "nextcloud_rds" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t4g.micro"
  identifier           = "qvos-rds"
  multi_az             = true
  publicly_accessible  = false
  storage_type         = "gp2"
  db_subnet_group_name = aws_db_subnet_group.nextcloud_rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  username             = "admin"
  password             = "password123"
  skip_final_snapshot  = true

  tags = local.tags
}

