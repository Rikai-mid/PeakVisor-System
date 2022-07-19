module "sg_rds" {
  source  = "cloudposse/security-group/aws"
  version = "1.0.1"

  attributes = ["mysql"]

  # Allow unlimited egress
  allow_all_egress = true

  rules = [
    {
      key         = "mysql"
      type        = "ingress"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24", "10.1.64.0/18", "10.1.128.0/18"]
      self        = null
      description = "Allow rds from private networks"
    }
  ]

  vpc_id = module.vpc.vpc_id
}
