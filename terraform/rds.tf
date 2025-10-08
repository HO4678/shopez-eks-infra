resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "shopez-rds-subnet"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "shopez-rds-subnet"
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "shopezdb"      # <-- use db_name, not name
  username             = var.db_username
  password             = var.db_password
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot  = true
  publicly_accessible  = false
  multi_az             = false
  storage_type         = "gp2"
}
