locals {

  username_password = {
    username = var.project_name
    password = var.admin_password
  }

  auth = [
    {
      auth_scheme = "SECRETS"
      description = "Access the database instance using username and password from AWS Secrets Manager"
      iam_auth    = "DISABLED"
      secret_arn  = aws_secretsmanager_secret.rds_username_and_password.arn
    }
  ]
}

resource "aws_secretsmanager_secret" "rds_username_and_password" {
  name                    = var.project_name
  description             = "RDS username and password"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "rds_username_and_password" {
  secret_id     = aws_secretsmanager_secret.rds_username_and_password.id
  secret_string = jsonencode(local.username_password)
}

module "rds_cluster_aurora" {
  source  = "cloudposse/rds-cluster/aws"
  version = "1.3.0"

  engine                 = "aurora-postgresql"
  cluster_family         = "aurora-postgresql13"
  cluster_size           = 1
  engine_version         = "13.7"
  namespace              = var.namespace
  stage                  = var.env
  name                   = var.project_name
  admin_user             = var.project_name
  admin_password         = var.admin_password
  db_name                = var.project_name
  instance_type          = "db.t3.medium"
  vpc_id                 = module.vpc.vpc_id
  vpc_security_group_ids = [module.sg_rds.id]
  subnets                = module.rds_private_subnets.private_subnet_ids
  zone_id                = [aws_route53_zone.private.zone_id]
  backup_window          = "19:00-21:00"
  maintenance_window     = "wed:16:00-wed:17:00"
}


module "rds_proxy" {
  source  = "cloudposse/rds-db-proxy/aws"
  version = "1.0.1"

  db_cluster_identifier  = module.rds_cluster_aurora.cluster_identifier
  auth                   = local.auth
  vpc_security_group_ids = [module.sg_rds.id]
  vpc_subnet_ids         = module.rds_private_subnets.private_subnet_ids


  namespace           = var.namespace
  stage               = var.env
  name                = var.project_name
  enabled             = true
  debug_logging       = true
  engine_family       = "POSTGRESQL"
  iam_role_attributes = ["rds"]
}
