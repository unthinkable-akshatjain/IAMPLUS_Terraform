locals {
  prefix = "${var.platform}-${var.host}-${var.env}"
  name = "${local.prefix}-${var.resource}"
  namespace = "${var.platform}"

  kms_description = "The KMS key for encrypt/decrypt EFS Data"
  kms_key_alias_name = "alias/${local.name}-key"
}