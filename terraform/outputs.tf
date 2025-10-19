output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "rds_endpoint" {
  value = aws_db_instance.rds.address
}

output "vpc_id" {
  value = module.vpc.vpc_id # use module output instead of aws_vpc.main
}
