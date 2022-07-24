module "waf" {
  source  = "cloudposse/waf/aws"
  version = "0.0.4"

  namespace      = var.namespace
  stage          = var.env
  name           = var.project_name
  scope          = "REGIONAL"
  default_action = "allow"

  managed_rule_group_statement_rules = [
    {
      name     = "rule-000"
      action   = "allow"
      priority = 1

      statement = {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }

      visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "rule-000-metric"
      }
    }
  ]

  rate_based_statement_rules = [
    {
      name     = "rule-001"
      action   = "block"
      priority = 10

      statement = {
        limit              = 10000
        aggregate_key_type = "IP"
      }

      visibility_config = {
        cloudwatch_metrics_enabled = false
        sampled_requests_enabled   = false
        metric_name                = "rule-001-metric"
      }
    }
  ]

}
