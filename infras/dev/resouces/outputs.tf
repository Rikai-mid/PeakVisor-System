output "bastion_public_subnets" {
  value = module.bastion_public_subnets
}

output "lambda_public_subnets" {
  value = module.lambda_public_subnets
}

output "iam_assumable_lambda_role_custom" {
  value = module.iam_assumable_lambda_role_custom
}

output "sg_lambda" {
  value = module.sg_lambda
}

output "vpc_endpoints" {
  value = module.vpc_endpoints
}
