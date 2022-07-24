module "rds_cluster_aurora" {
  source  = "cloudposse/rds-cluster/aws"
  version = "1.3.0"

  engine                 = "aurora-postgresql"
  cluster_family         = "aurora-postgresql14"
  cluster_size           = 1
  engine_version         = "14.3"
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
}
