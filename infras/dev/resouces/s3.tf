module "s3_log_bucket" {
  source = "cloudposse/s3-bucket/aws"
  version = "2.0.3"

  acl                      = "private"
  enabled                  = true
  user_enabled             = false
  versioning_enabled       = false
  name                     = "${var.project_name}-log-bucket"
  stage                    = var.env
  namespace                = var.namespace
}

module "s3_content_bucket" {
  source = "cloudposse/s3-bucket/aws"
  version = "2.0.3"

  acl                      = "public-read"
  enabled                  = true
  user_enabled             = false
  versioning_enabled       = false
  block_public_acls        = false
  restrict_public_buckets  = false
  block_public_policy      = false
  ignore_public_acls       = true
  name                     = "${var.project_name}-content-bucket"
  stage                    = var.env
  namespace                = var.namespace
}

# module "s3_upload_bucket" {
#   source = "cloudposse/s3-bucket/aws"
#   version = "2.0.3"

#   acl                      = "private"
#   enabled                  = true
#   user_enabled             = false
#   versioning_enabled       = false
#   name                     = "${var.project_name}-upload-bucket"
#   stage                    = var.env
#   namespace                = var.namespace
# }

# module "s3_correct_data_bucket" {
#   source = "cloudposse/s3-bucket/aws"
#   version = "2.0.3"

#   acl                      = "private"
#   enabled                  = true
#   user_enabled             = false
#   versioning_enabled       = false
#   name                     = "${var.project_name}-correct-data-bucket"
#   stage                    = var.env
#   namespace                = var.namespace
# }