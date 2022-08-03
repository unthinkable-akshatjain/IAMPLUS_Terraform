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
  "Statement": [{
      "Action": [
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::omega-maf-stage-elasticsearch-backups"
      ]
    },
    {
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::omega-maf-stage-elasticsearch-backups/*"
      ]
    }
  ]
}
EOF
}

inputs = {
    name = "omega-maf-stage-elasticsearch-put-snapshot"
    description = "Policy for API access for ElasticSearch"
    policy = local.policy
    tags = include.locals.tags
}
