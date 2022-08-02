resource "aws_iam_role" "iam_role" {
  name                  = var.name
  assume_role_policy    = var.assume_role_policy
  managed_policy_arns   = var.managed_policy_arns
  force_detach_policies = true
  tags                  = var.tags
  max_session_duration  = var.max_session_duration
}
