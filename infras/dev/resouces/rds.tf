module "rds_cluster_aurora_mysql" {
  source = "cloudposse/rds-cluster/aws"

  version        = "1.3.0"
  engine         = "aurora"
  cluster_family = "aurora-mysql5.7"
  cluster_size   = 2
  namespace      = var.namespace
  stage          = var.env
  name           = var.project_name
  admin_user     = var.project_name
  #   admin_password  = "Test123456789"
  db_name         = var.project_name
  instance_type   = "db.t3.small"
  vpc_id          = module.vpc.vpc_id
  security_groups = [module.sg_rds.id]
  subnets         = module.rds_private_subnets.private_subnet_cidrs
  zone_id         = [aws_route53_zone.private.zone_id]

  cluster_parameters = [
    {
      name         = "character_set_client"
      value        = "utf8mb4"
      apply_method = "apply_immediately"
    },
    {
      name         = "character_set_connection"
      value        = "utf8mb4"
      apply_method = "apply_immediately"
    },
    {
      name         = "character_set_database"
      value        = "utf8mb4"
      apply_method = "apply_immediately"
    },
    {
      name         = "character_set_results"
      value        = "utf8mb4"
      apply_method = "apply_immediately"
    },
    {
      name         = "character_set_server"
      value        = "utf8mb4"
      apply_method = "apply_immediately"
    },
    {
      name         = "collation_server"
      value        = "utf8mb4_general_ci"
      apply_method = "apply_immediately"
    },
    {
      name         = "time_zone"
      value        = "UTC+9"
      apply_method = "apply_immediately"
    },
    {
      name         = "slow_query_log"
      value        = "1"
      apply_method = "apply_immediately"
    },
    {
      name         = "long_query_time"
      value        = "10"
      apply_method = "apply_immediately"
    },
    {
      name         = "general_log"
      value        = "1"
      apply_method = "apply_immediately"
    }
  ]
}
