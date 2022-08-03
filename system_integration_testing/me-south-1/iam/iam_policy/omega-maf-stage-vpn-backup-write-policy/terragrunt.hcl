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
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::omega-maf-stage-vpn-backup/*",
            "Effect": "Allow"
        }
    ]
}
EOF
}

inputs = {
    name = "omega-maf-stage-vpn-backup-write-policy"
    description = "Policy for VPN Backup Write"
    policy = local.policy
    tags = include.locals.tags
}
