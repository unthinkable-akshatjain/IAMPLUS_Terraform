resource "aws_kms_key" "msk_rest_key" {
  description             = local.msk_kms_description
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
resource "aws_kms_alias" "msk-rest-key-alias" {
  name          = local.kms_key_alias_name
  target_key_id = aws_kms_key.msk_rest_key.key_id
}
