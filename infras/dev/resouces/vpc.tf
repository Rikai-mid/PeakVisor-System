module "vpc" {
  source    = "cloudposse/vpc/aws"
  version   = "1.1.0"
  namespace = var.namespace
  stage     = var.env
  name      = var.project_name

  ipv4_primary_cidr_block = var.cidr_block

  assign_generated_ipv6_cidr_block = false
}

module "rds_private_subnets" {
  source                  = "cloudposse/dynamic-subnets/aws"
  version                 = "2.0.2"
  namespace               = var.namespace
  stage                   = var.env
  name                    = "${var.project_name}-rds"
  availability_zones      = var.availability_zones
  vpc_id                  = module.vpc.vpc_id
  igw_id                  = [module.vpc.igw_id]
  ipv4_cidrs              = [{ public = [], private = ["10.1.0.0/24", "10.1.1.0/24"] }]
  nat_gateway_enabled     = false
  nat_instance_enabled    = false
  ipv4_enabled            = true
  ipv6_enabled            = false
  private_subnets_enabled = true
  public_subnets_enabled  = false
}

module "asg_private_subnets" {
  source                  = "cloudposse/dynamic-subnets/aws"
  version                 = "2.0.2"
  namespace               = var.namespace
  stage                   = var.env
  name                    = "${var.project_name}-rds"
  availability_zones      = var.availability_zones
  vpc_id                  = module.vpc.vpc_id
  igw_id                  = [module.vpc.igw_id]
  ipv4_cidrs              = [{ public = [], private = ["10.1.2.0/24", "10.1.3.0/24"] }]
  nat_gateway_enabled     = false
  nat_instance_enabled    = false
  ipv4_enabled            = true
  ipv6_enabled            = false
  private_subnets_enabled = true
  public_subnets_enabled  = false
}

module "bastion_public_subnets" {
  source                  = "cloudposse/dynamic-subnets/aws"
  version                 = "2.0.2"
  namespace               = var.namespace
  stage                   = var.env
  name                    = "${var.project_name}-lambda"
  availability_zones      = var.availability_zones
  vpc_id                  = module.vpc.vpc_id
  igw_id                  = [module.vpc.igw_id]
  ipv4_cidrs              = [{ public = ["10.1.4.0/24", "10.1.5.0/24"], private = [] }]
  nat_gateway_enabled     = false
  nat_instance_enabled    = false
  ipv4_enabled            = true
  ipv6_enabled            = false
  private_subnets_enabled = false
  public_subnets_enabled  = true
}

module "lambda_public_subnets" {
  source                  = "cloudposse/dynamic-subnets/aws"
  version                 = "2.0.2"
  namespace               = var.namespace
  stage                   = var.env
  name                    = "${var.project_name}-lambda"
  availability_zones      = var.availability_zones
  vpc_id                  = module.vpc.vpc_id
  igw_id                  = [module.vpc.igw_id]
  ipv4_cidrs              = [{ public = ["10.1.64.0/18", "10.1.128.0/18"], private = [] }]
  nat_gateway_enabled     = false
  nat_instance_enabled    = false
  ipv4_enabled            = true
  ipv6_enabled            = false
  private_subnets_enabled = false
  public_subnets_enabled  = true
}

resource "aws_route53_zone" "private" {
  name = "${var.project_name}.vpc"

  vpc {
    vpc_id = module.vpc.vpc_id
  }
}
