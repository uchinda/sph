data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.eks_cluster_name
  cluster_version = var.eks_cluster_version
  subnets         = module.vpc.private_subnets

  tags = {
    Environment = "assignment"
  }

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t3.medium"
      asg_desired_capacity          = 1
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
  ]

  worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  #   map_roles                            = var.eks_map_roles
  #   map_users                            = var.eks_map_users
  #   map_accounts                         = var.eks_map_accounts
}