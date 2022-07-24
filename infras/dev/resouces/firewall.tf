module "sg_rds" {
  source  = "cloudposse/security-group/aws"
  version = "1.0.1"

  attributes = ["db"]

  # Allow unlimited egress
  allow_all_egress = true

  rules = [
    {
      key         = "postgres"
      type        = "ingress"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24", "10.1.64.0/18", "10.1.4.0/24", "10.1.5.0/24", "10.1.128.0/18"]
      self        = null
      description = "Allow rds from private networks"
    }
  ]

  vpc_id = module.vpc.vpc_id
}

module "sg_bastion" {
  source  = "cloudposse/security-group/aws"
  version = "1.0.1"

  attributes = ["bastion"]

  # Allow unlimited egress
  allow_all_egress = true

  rules = [
    {
      key         = "ssh"
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null
      description = "Allow ssh from public networks"
    }
  ]

  vpc_id = module.vpc.vpc_id
}

module "sg_lambda" {
  source  = "cloudposse/security-group/aws"
  version = "1.0.1"

  attributes = ["lambda"]

  # Allow unlimited egress
  allow_all_egress = true

  rules = [
    {
      key         = "http"
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null
      description = "Allow http from public networks"
    }
  ]

  vpc_id = module.vpc.vpc_id
}
