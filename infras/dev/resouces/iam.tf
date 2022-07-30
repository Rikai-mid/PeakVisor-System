module "iam_assumable_lambda_role_custom" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.2.0"

  trusted_role_services = [
    "lambda.amazonaws.com"
  ]

  create_role = true

  role_name           = "${var.project_name}-lambda-role"
  role_requires_mfa   = false
  role_sts_externalid = []

  custom_role_policy_arns = [
    module.iam_lambda_policy.arn,
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  ]
}

module "iam_lambda_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.2.0"

  name        = "${var.project_name}-lambda-policy"
  path        = "/"
  description = "${var.project_name}-lambda-policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ssm:GetParameter",
        "ssm:GetParameters"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter:*"
    },
    {
      "Action": [
        "kms:Decrypt"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:kms:ap-northeast-1:${data.aws_caller_identity.current.account_id}:key/039a43a7-6747-448b-9254-b415e33bbda3"
    }
  ]
}
EOF
}

module "iam_assumable_lambda_role_utils" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.2.0"

  trusted_role_services = [
    "lambda.amazonaws.com"
  ]

  create_role = true

  role_name           = "${var.project_name}-lambda-utils-role"
  role_requires_mfa   = false
  role_sts_externalid = []

  custom_role_policy_arns = [
    module.iam_lambda_utils_policy.arn,
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  ]
}

module "iam_lambda_utils_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.2.0"

  name        = "${var.project_name}-lambda-utils-policy"
  path        = "/"
  description = "${var.project_name}-lambda-utils-policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "rds:DescribeDBClusterParameters",
        "rds:StartDBCluster",
        "rds:StopDBCluster",
        "rds:DescribeDBEngineVersions",
        "rds:DescribeGlobalClusters",
        "rds:DescribePendingMaintenanceActions",
        "rds:DescribeDBLogFiles",
        "rds:StopDBInstance",
        "rds:StartDBInstance",
        "rds:DescribeReservedDBInstancesOfferings",
        "rds:DescribeReservedDBInstances",
        "rds:ListTagsForResource",
        "rds:DescribeValidDBInstanceModifications",
        "rds:DescribeDBInstances",
        "rds:DescribeSourceRegions",
        "rds:DescribeDBClusterEndpoints",
        "rds:DescribeDBClusters",
        "rds:DescribeDBClusterParameterGroups",
        "rds:DescribeOptionGroups"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "logs:CreateExportTask",
        "logs:Describe*",
        "logs:ListTagsLogGroup"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ssm:GetParameter",
        "ssm:GetParameters",
        "ssm:PutParameter"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter:*"
    },
    {
      "Action": [
        "kms:Decrypt"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:kms:ap-northeast-1:${data.aws_caller_identity.current.account_id}:key/039a43a7-6747-448b-9254-b415e33bbda3"
    }
  ]
}
EOF
}
