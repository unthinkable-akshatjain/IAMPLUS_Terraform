# The KMS key is used for the encryption and decryption
# the default customer master key is SYMMETRIC_DEFAULT

resource "aws_kms_key" "logs_eks_key" {
  description             = local.logs_kms_description
  deletion_window_in_days = 10
  enable_key_rotation     = true
  policy = <<POLICY
{
 "Version": "2012-10-17",
    "Id": "key-default-1",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::541045388833:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "logs.${var.region}.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt*",
                "kms:Decrypt*",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:Describe*"
            ],
            "Resource": "*",
            "Condition": {
                "ArnEquals": {
                    "kms:EncryptionContext:aws:logs:arn": "arn:aws:logs:me-south-1:541045388833:log-group:/aws/eks/${local.cluster_name}*"
                }
            }
        }    
    ]
}
POLICY
  tags                    = var.tags
}

# KMS Alias for the key
resource "aws_kms_alias" "logs_eks_key_alias" {
  name          = local.logs_kms_key_alias_name
  target_key_id = aws_kms_key.logs_eks_key.key_id
}