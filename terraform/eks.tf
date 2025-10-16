module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.3.2"

  name              = var.cluster_name
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = concat(module.vpc.public_subnets, module.vpc.private_subnets)
  kubernetes_version = "1.30"

  eks_managed_node_groups = {
    ng-public = {
      instance_type = "t3.medium"
      desired_size  = 2
      subnet_ids    = module.vpc.public_subnets
      min_size      = 1
      max_size      = 3
    }
  }

  fargate_profiles = {
    default = {
      name      = "fp-default"
      selectors = [{ namespace = "default" }]
      subnet_ids = module.vpc.private_subnets
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


