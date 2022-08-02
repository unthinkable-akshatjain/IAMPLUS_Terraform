module "es_cluster" {
  source         = "git::https://github.com/cloudposse/terraform-aws-elasticsearch.git?ref=0.33.1"

  name                      = local.cluster_name
  tags                      = var.tags
  
  vpc_id                    = var.vpc_id
  subnet_ids                = var.subnets
  allowed_cidr_blocks       = [var.vpc_cidr]
  security_groups           = [module.es_security_group.security_group_id]
  custom_endpoint           = var.custom_endpoint
  custom_endpoint_enabled   = true
  custom_endpoint_certificate_arn = var.acm_arn
  create_iam_service_linked_role = var.create_iam_service_linked_role

  zone_awareness_enabled    = true

  elasticsearch_version     = var.es_version

  dedicated_master_count    = var.require_dedicated_master ? var.required_dedicated_master_count : 0
  dedicated_master_enabled  = var.require_dedicated_master ? true : false
  dedicated_master_type     = var.instance_type

  instance_type             = var.instance_type
  instance_count            = var.worker_node_instance_count
  ebs_volume_size           = var.ebs_volume_size

  encrypt_at_rest_enabled   = true
  encrypt_at_rest_kms_key_id = aws_kms_key.es_rest_key.arn

  availability_zone_count   = var.availability_zone_count

  log_publishing_application_enabled = true
  log_publishing_application_cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_application.arn

  log_publishing_audit_enabled = true
  log_publishing_audit_cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_audit.arn

  log_publishing_search_enabled = true
  log_publishing_search_cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_search.arn

  log_publishing_index_enabled = true
  log_publishing_index_cloudwatch_log_group_arn = aws_cloudwatch_log_group.es_index.arn

  node_to_node_encryption_enabled = true
  advanced_security_options_enabled = true
  advanced_security_options_internal_user_database_enabled = true
  advanced_security_options_master_user_name = var.username
  advanced_security_options_master_user_password = var.password
  
  iam_role_arns             = var.iam_role_arn
  #iam_role_arns            = [format("arn:aws:es:%s:%s:domain/%s-logs-es-%s/*",local.aws_region,data.aws_caller_identity.current.account_id,local.platform,local.environment)]
  iam_actions             = ["es:*"]

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }
 
}