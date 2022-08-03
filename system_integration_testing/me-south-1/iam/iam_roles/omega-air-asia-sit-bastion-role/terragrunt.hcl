include {
  path = find_in_parent_folders()
  expose = true
}

terraform {
    source = "../../../../../modules//iam/iam_role/"
}

dependency "eks-access-policy" {
    config_path = "../../iam_policy/eks-access-policy"
}

locals {
    resource = "bastion"
    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
    POLICY
    managed_policy_arns = [
        "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    ]
}

inputs = {
    name = "${include.locals.platform}-${include.locals.host}-${include.locals.env}-${local.resource}-role"
    assume_role_policy = local.assume_role_policy
    managed_policy_arns = concat(local.managed_policy_arns, ["${dependency.eks-access-policy.outputs.policy_arn}"])
    tags = include.locals.tags
}