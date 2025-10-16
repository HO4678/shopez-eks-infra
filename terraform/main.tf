resource "aws_security_group" "eks_sg" {
  name        = "shopez-eks-sg"
  vpc_id = module.vpc.vpc_id
  description = "Allow internal and EKS traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "shopez-eks-sg"
  }
}
