locals {
  vpc_name         = var.vpc_name
  cidr_prefix      = "10.0"
  eks_cluster_name = var.eks_cluster_name
  db_name          = var.db_name
  db_tags = {
    Owner       = "sph"
    Environment = "assignment"
  }
}