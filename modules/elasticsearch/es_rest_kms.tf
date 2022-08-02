# The KMS key is used for the encryption and decryption
# the default customer master key is SYMMETRIC_DEFAULT

resource "aws_kms_key" "es_rest_key" {
  description             = local.es_kms_description
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
                "Service": "logs.me-south-1.amazonaws.com"
            },
            "Action": [
                "kms:Encrypt*",
                "kms:Decrypt*",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:Describe*"
            ],
            "Resource": "*"
        }    
    ]
}
POLICY
  tags                    = var.tags
}

# KMS Alias for the key
resource "aws_kms_alias" "es_rest_key_alias" {
  name          = local.es_rest_kms_key_alias_name
  target_key_id = aws_kms_key.es_rest_key.key_id
}