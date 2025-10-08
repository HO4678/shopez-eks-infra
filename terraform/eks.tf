module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.3.2"

  name       = var.cluster_name
  vpc_id     = aws_vpc.main.id
  subnet_ids = concat(aws_subnet.public[*].id, aws_subnet.private[*].id)

  # Fargate only
  fargate_profiles = {
    default = {
      name      = "fp-default"
      selectors = [{ namespace = "default" }]
    }
  }

  tags = {
    Environment = "dev"
    Project     = "ShopEZ"
  }
}

# Outputs
output "eks_cluster_name" {
  value = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}


