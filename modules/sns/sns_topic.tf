resource "aws_sns_topic" "sns_topic" {
    name = "${local.name_prefix}-${local.name}"
    delivery_policy = var.delivery_policy
    kms_master_key_id = "alias/aws/sns" 
    tags = var.tags
}