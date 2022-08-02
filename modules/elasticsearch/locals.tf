locals {
  es_prefix = "${var.platform}-${var.host}-${var.env}"
  cluster_name = "${local.es_prefix}-${var.resource}"

  es_rest_kms_key_alias_name = "alias/${local.cluster_name}-rest-key"
  es_kms_description = "This key to encrypt the Elasticsearch on rest"
}