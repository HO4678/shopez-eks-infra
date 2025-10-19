# DB Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "shopez-rds-subnet"
  subnet_ids = module.vpc.private_subnets # use private subnets from VPC module

  tags = {
    Name    = "shopez-rds-subnet"
    Project = "ShopEZ"
  }
}

# RDS Instance
resource "aws_db_instance" "rds" {
  allocated_storage = 20
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  db_name           = "shopezdb"
  username          = var.db_username
  password          = var.db_password

  # Reference the RDS security group defined in security.tf
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name

  skip_final_snapshot = true
  publicly_accessible = false
  multi_az            = false
  storage_type        = "gp2"

  tags = {
    Name    = "shopez-rds"
    Project = "ShopEZ"
  }
}
