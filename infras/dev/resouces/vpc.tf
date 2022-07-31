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

module "vpc_endpoints" {
  source  = "cloudposse/vpc/aws//modules/vpc-endpoints"
  version = "1.1.0"

  namespace = var.namespace
  stage     = var.env
  name      = var.project_name
  vpc_id    = module.vpc.vpc_id

  gateway_vpc_endpoints = {
    "s3" = {
      name = "s3"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "s3:*",
            ]
            Effect    = "Allow"
            Principal = "*"
            Resource  = "*"
          },
        ]
      })
    }
  }

  interface_vpc_endpoints = {
    "execute-api" = {
      name                = "execute-api"
      security_group_ids  = [module.vpc.vpc_default_security_group_id]
      subnet_ids          = module.lambda_public_subnets.public_subnet_ids
      policy              = null
      private_dns_enabled = true
    }
  }

}

resource "aws_vpc_endpoint_route_table_association" "rds_private_subnets" {
  count           = length(module.rds_private_subnets.private_route_table_ids)
  route_table_id  = module.rds_private_subnets.private_route_table_ids[count.index]
  vpc_endpoint_id = module.vpc_endpoints.gateway_vpc_endpoints[0].id
}

resource "aws_vpc_endpoint_route_table_association" "asg_private_subnets" {
  count           = length(module.asg_private_subnets.private_route_table_ids)
  route_table_id  = module.asg_private_subnets.private_route_table_ids[count.index]
  vpc_endpoint_id = module.vpc_endpoints.gateway_vpc_endpoints[0].id
}

resource "aws_vpc_endpoint_route_table_association" "bastion_public_subnets" {
  count           = length(module.bastion_public_subnets.public_route_table_ids)
  route_table_id  = module.bastion_public_subnets.public_route_table_ids[count.index]
  vpc_endpoint_id = module.vpc_endpoints.gateway_vpc_endpoints[0].id
}

resource "aws_vpc_endpoint_route_table_association" "lambda_public_subnets" {
  count           = length(module.lambda_public_subnets.public_route_table_ids)
  route_table_id  = module.lambda_public_subnets.public_route_table_ids[count.index]
  vpc_endpoint_id = module.vpc_endpoints.gateway_vpc_endpoints[0].id
}
