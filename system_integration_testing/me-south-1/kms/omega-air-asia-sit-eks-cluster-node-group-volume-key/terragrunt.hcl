include {
  path = find_in_parent_folders()
  expose = true
}

terraform {
    source = "../../../../modules//kms//"
}

locals {
    resource = "eks-cluster-node-group-volume"
}

inputs = {
    tags = include.locals.tags
    kms_description = "This Key is used to encrypt the k8s nodes volume."
    kms_key_alias_name = "alias/${include.locals.platform}-${include.locals.host}-${include.locals.env}-${local.resource}-key"
    policy =<<EOF
{
    "Version": "2012-10-17",
    "Id": "key-default-1",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::067487547552:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow service-linked role use of the customer managed key",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::067487547552:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
                ]
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow attachment of persistent resources",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                    "arn:aws:iam::067487547552:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
                ]
            },
            "Action": [
                "kms:CreateGrant"
            ],
            "Resource": "*",
            "Condition": {
                "Bool": {
                    "kms:GrantIsForAWSResource": true
                }
                }
        }
    ]
}
    EOF
}
