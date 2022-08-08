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
    "Effect": "Allow",
    "Action": "sns:Publish",
    "Resource": "arn:aws:sns:ap-south-1:67487547552:omega-air-asia-sit-Zipkin-HTTPS-alerts"
  }]
}
EOF
}

inputs = {
    name = "omega-air-asia-sit-Zipkin-HTTPS-alerts-policy"
    description = "Policy for Carrefour Assests bucket access through k8s"
    policy = local.policy
    tags = include.locals.tags
}
