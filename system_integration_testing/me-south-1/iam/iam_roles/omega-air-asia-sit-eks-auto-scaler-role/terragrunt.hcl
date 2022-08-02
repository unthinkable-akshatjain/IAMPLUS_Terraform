include {
  path = find_in_parent_folders()
  expose = true
}

terraform {
    source = "../../../../../modules/iam//iam_role//"
}

dependencies {
  paths = [
      "../../iam_policy/omega-air-asia-sit-eks-auto-scaler-policy",
      "../../../eks/omega-air-asia-sit-eks-cluster"
    ]
}

dependency "eks-auto-scaler-policy" {
    config_path = "../../iam_policy/omega-air-asia-sit-eks-auto-scaler-policy"
}

dependency "eks_oidc" {
    config_path = "../../../eks/omega-air-asia-sit-eks-cluster"
}

locals {
    resource = "eks-auto-scaler"
    managed_policy_arns = []
}

inputs = {
    name = "${include.locals.platform}-${include.locals.host}-${include.locals.env}-${local.resource}-role"
    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "${dependency.eks_oidc.outputs.oidc_arn}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "${dependency.eks_oidc.outputs.cluster_oidc_issuer_url}": "sts.amazonaws.com"
                }
            }
        }
    ]
}
    POLICY
    managed_policy_arns = concat(local.managed_policy_arns, ["${dependency.eks-auto-scaler-policy.outputs.policy_arn}"])
    tags = include.locals.tags
}