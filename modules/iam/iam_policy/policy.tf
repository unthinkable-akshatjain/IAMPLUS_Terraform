resource "aws_iam_policy" "policy" {
  name        = var.name
  description = var.description

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = var.policy
  tags = var.tags
}