data "aws_availability_zones" "available" {
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.2"

  name                 = local.vpc_name
  cidr                 = "${local.cidr_prefix}.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["${local.cidr_prefix}.1.0/24", "${local.cidr_prefix}.2.0/24", "${local.cidr_prefix}.3.0/24"]
  public_subnets       = ["${local.cidr_prefix}.4.0/24", "${local.cidr_prefix}.5.0/24", "${local.cidr_prefix}.6.0/24"]
  database_subnets     = ["${local.cidr_prefix}.7.0/24", "${local.cidr_prefix}.8.0/24", "${local.cidr_prefix}.9.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                          = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"                 = "1"
  }

  tags = {
    "terraform" = "true"
  }
}