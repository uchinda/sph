module "aurora" {
  source = "terraform-aws-modules/rds-aurora/aws"

  name                  = local.db_name
  engine                = var.rds_engine_type
  engine_version        = var.rds_engine_version
  instance_type         = var.rds_instance_type
  instance_type_replica = var.rds_replica_instance_type

  vpc_id                = module.vpc.vpc_id
  db_subnet_group_name  = module.vpc.database_subnet_group_name
  create_security_group = true
  allowed_cidr_blocks   = module.vpc.private_subnets_cidr_blocks

  replica_count                       = 1
  iam_database_authentication_enabled = true
  database_name                       = var.rds_db_name
  password                            = var.db_password
  create_random_password              = false

  apply_immediately   = true
  skip_final_snapshot = true

  db_parameter_group_name         = aws_db_parameter_group.sph_db.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.sph_db.id
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  tags = local.db_tags
}

resource "aws_db_parameter_group" "sph_db" {
  name        = "${local.db_name}-aurora-db-57-parameter-group"
  family      = "aurora-mysql5.7"
  description = "${local.db_name}-aurora-db-57-parameter-group"
  tags        = local.db_tags
}

resource "aws_rds_cluster_parameter_group" "sph_db" {
  name        = "${local.db_name}-aurora-57-cluster-parameter-group"
  family      = "aurora-mysql5.7"
  description = "${local.db_name}-aurora-57-cluster-parameter-group"
  tags        = local.db_tags
}