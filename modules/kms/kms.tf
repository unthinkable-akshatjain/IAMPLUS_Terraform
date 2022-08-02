# The KMS key is used for the encryption and decryption
# the default customer master key is SYMMETRIC_DEFAULT

resource "aws_kms_key" "kms_key" {
  description             = var.kms_description
  deletion_window_in_days = 10
  enable_key_rotation     = true
  tags                    = var.tags
  policy                  = var.policy
}

# KMS Alias for the key
resource "aws_kms_alias" "logs_eks_key_alias" {
  name          = var.kms_key_alias_name
  target_key_id = aws_kms_key.kms_key.key_id
}
