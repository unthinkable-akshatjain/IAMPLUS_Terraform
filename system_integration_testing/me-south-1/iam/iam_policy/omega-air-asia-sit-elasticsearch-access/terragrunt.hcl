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
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "arn:aws:iam::067487547552:role/omega-air-asia-sit-elasticsearch-put-snapshot-role"
        },
        {
            "Sid": "ESAccess",
            "Effect": "Allow",
            "Action": [
                "es:ESHttpHead",
                "es:ESHttpPost",
                "es:ESHttpGet",
                "es:ESHttpPatch",
                "es:ESHttpDelete"
            ],
            "Resource": "arn:aws:es:*:681257129225:domain/*"
        }
    ]
}
EOF
}

inputs = {
    name = "omega-air-asia-sit-elasticsearch-access"
    description = "Policy for API access for ElasticSearch"
    policy = local.policy
    tags = include.locals.tags
}
