include {
  path = find_in_parent_folders()
  expose = true
}

terraform {
    source = "../../../../../modules/iam//iam_policy//"
}

locals {
    policy =<<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketPolicyStatus",
                "s3:GetBucketTagging",
                "s3:GetObjectRetention",
                "s3:GetObjectVersionTagging",
                "s3:ListBucketVersions",
                "s3:ListBucket",
                "s3:GetBucketVersioning",
                "s3:GetObjectLegalHold",
                "s3:GetBucketAcl",
                "s3:GetBucketPolicy",
                "s3:GetObjectVersionTorrent",
                "s3:PutObject",
                "s3:GetObjectAcl",
                "s3:GetObject",
                "s3:GetObjectTorrent",
                "s3:PutObjectVersionAcl",
                "s3:GetObjectVersionAcl",
                "s3:GetObjectTagging",
                "s3:GetObjectVersionForReplication",
                "s3:PutBucketVersioning",
                "s3:PutObjectAcl",
                "s3:GetObjectVersion"
            ],
            "Resource": [
                "arn:aws:s3:::omega-maf-stage-carrefour-shopping-assets",
                "arn:aws:s3:::omega-maf-stage-carrefour-shopping-assets/*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:GetAccessPoint",
                "s3:ListAllMyBuckets"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

inputs = {
    name = "omega-maf-stage-carrefour-assests-k8s-s3-bucket-access"
    description = "Policy for Carrefour Assests bucket access through k8s"
    policy = local.policy
    tags = include.locals.tags
}
