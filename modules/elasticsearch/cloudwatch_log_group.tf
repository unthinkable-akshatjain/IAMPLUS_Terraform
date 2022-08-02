data "aws_iam_policy_document" "elasticsearch-log-publishing-policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]

    resources = ["arn:aws:logs:*"]

    principals {
      identifiers = ["es.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_cloudwatch_log_resource_policy" "elasticsearch-log-publishing-policy" {
  policy_document = data.aws_iam_policy_document.elasticsearch-log-publishing-policy.json
  policy_name     = "elasticsearch-log-publishing-policy-${local.cluster_name}"
}

resource "aws_cloudwatch_log_group" "es_application" {
  name = "${local.cluster_name}-application-logs"
  retention_in_days = "30"
  kms_key_id = aws_kms_key.es_rest_key.arn

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "es_audit" {
  name = "${local.cluster_name}-audit-logs"
  retention_in_days = "30"
  kms_key_id = aws_kms_key.es_rest_key.arn

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "es_search" {
  name = "${local.cluster_name}-search-logs"
  retention_in_days = "30"
  kms_key_id = aws_kms_key.es_rest_key.arn

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "es_index" {
  name = "${local.cluster_name}-index-logs"
  retention_in_days = "30"
  kms_key_id = aws_kms_key.es_rest_key.arn

  tags = var.tags
}