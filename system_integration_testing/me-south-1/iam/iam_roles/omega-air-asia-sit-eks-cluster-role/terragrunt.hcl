include {
  path = find_in_parent_folders()
  expose = true
}

terraform {
    source = "../../../../../modules/iam//iam_role//"
}

locals {
    
    resource = "eks-cluster"
    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
    POLICY
    managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy", "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"]
}

inputs = {
    name = "${include.locals.platform}-${include.locals.host}-${include.locals.env}-${local.resource}-role"
    assume_role_policy = local.assume_role_policy
    managed_policy_arns = local.managed_policy_arns
    tags = include.locals.tags
}
