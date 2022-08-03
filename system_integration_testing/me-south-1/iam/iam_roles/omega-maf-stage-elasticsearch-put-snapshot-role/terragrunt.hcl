include {
  path = find_in_parent_folders()
  expose = true
}

terraform {
    source = "../../../../../modules/iam//iam_role//"
}

dependencies {
  paths = [
      "../../iam_policy/omega-maf-stage-elasticsearch-put-snapshot-policy"
    ]
}

dependency "elasticsearch-put-snapshot-policy" {
    config_path = "../../iam_policy/omega-maf-stage-elasticsearch-put-snapshot-policy"
}

locals {
    resource = "elasticsearch-put-snapshot"
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
                "Service": "es.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
    POLICY
    managed_policy_arns = concat(local.managed_policy_arns, ["${dependency.elasticsearch-put-snapshot-policy.outputs.policy_arn}"])
    tags = include.locals.tags
}