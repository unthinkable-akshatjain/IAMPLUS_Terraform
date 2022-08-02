resource "aws_cloudwatch_log_group" "msk_logs" {
  name = "${local.cluster_name}-msk-logs"
  retention_in_days = "30"
  kms_key_id = aws_kms_key.msk_rest_key.arn

  tags = var.tags
}
