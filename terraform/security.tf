# Security group for RDS instance
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow EKS nodes to connect to RDS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [module.eks.cluster_primary_security_group_id] # allow traffic from EKS
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
    Project = "ShopEZ"
  }
}
