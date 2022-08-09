include {
  path = find_in_parent_folders()
  expose = true
}

terraform {
    source = "../../../../../modules/iam//iam_role//"
}

dependencies {
  paths = [
      "../../iam_policy/omega-air-asia-sit-elasticsearch-access"
    ]
}

dependency "elasticsearch-access-policy" {
    config_path = "../../iam_policy/omega-air-asia-sit-elasticsearch-access"
}

locals {
    resource = "elasticsearch-access"
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
                "AWS": "arn:aws:iam::067487547552:root"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
    POLICY
    managed_policy_arns = concat(local.managed_policy_arns, ["${dependency.elasticsearch-access-policy.outputs.policy_arn}"])
    tags = include.locals.tags
}
