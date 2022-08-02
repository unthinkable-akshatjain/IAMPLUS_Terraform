# The KMS key is used for the encryption and decryption
# the default customer master key is SYMMETRIC_DEFAULT

resource "aws_kms_key" "rds_key" {
  description             = local.rds_kms_description
  deletion_window_in_days = 10
  enable_key_rotation     = true
  tags                    = var.tags
}

# KMS Alias for the key
resource "aws_kms_alias" "rds_key_alias" {
  name          = local.rds_kms_key_alias_name
  target_key_id = aws_kms_key.rds_key.key_id
}