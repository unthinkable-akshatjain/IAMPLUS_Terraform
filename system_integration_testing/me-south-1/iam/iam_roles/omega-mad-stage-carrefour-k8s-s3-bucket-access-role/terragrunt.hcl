include {
  path = find_in_parent_folders()
  expose = true
}

terraform {
    source = "../../../../../modules/iam//iam_role//"
}

dependencies {
  paths = [
      "../../iam_policy/omega-maf-stage-carrefour-k8s-s3-bucket-access",
      "../../../eks/omega-maf-stage-eks-cluster"
    ]
}

dependency "carrefour-assets-access-policy" {
    config_path = "../../iam_policy/omega-maf-stage-carrefour-k8s-s3-bucket-access"
}

dependency "eks_oidc" {
    config_path = "../../../eks/omega-maf-stage-eks-cluster"
}

locals {
    resource = "carrefour-assets-k8s-access"
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
                    "${trimprefix(dependency.eks_oidc.outputs.cluster_oidc_issuer_url, "https://")}:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
    POLICY
    managed_policy_arns = concat(local.managed_policy_arns, ["${dependency.carrefour-assets-access-policy.outputs.policy_arn}"])
    tags = include.locals.tags
}