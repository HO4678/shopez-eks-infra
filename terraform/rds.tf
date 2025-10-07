resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "shopez-rds-subnet"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "shopez-rds-subnet"
  }
}

resource "aws_db_instance" "rds" {
  identifier              = "shopez-db"
  engine                  = "postgres"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  name                    = "shopezdb"
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  skip_final_snapshot     = true
  publicly_accessible     = false

  vpc_security_group_ids = [aws_security_group.eks_sg.id]

  tags = {
    Name = "shopez-rds"
  }
}
