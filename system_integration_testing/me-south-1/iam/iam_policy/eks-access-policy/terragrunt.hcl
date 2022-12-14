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
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "eks:*",
            "Resource": [
                "arn:aws:eks:*:067487547552:cluster/*",
                "arn:aws:eks:*:067487547552:addon/*/*/*",
                "arn:aws:eks:*:067487547552:identityproviderconfig/*/*/*/*",
                "arn:aws:eks:*:067487547552:nodegroup/*/*/*"
            ]
        }
    ]
}
EOF
}

inputs = {
    name = "eks-access-policy-bastion"
    description = "Policy for EKS Access"
    policy = local.policy
    tags = include.locals.tags
}
