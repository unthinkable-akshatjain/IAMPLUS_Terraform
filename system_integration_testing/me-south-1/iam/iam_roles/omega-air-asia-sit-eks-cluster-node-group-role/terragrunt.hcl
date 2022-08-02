include {
  path = find_in_parent_folders()
  expose = true
}

terraform {
    source = "../../../../../modules/iam//iam_role//"
}

locals {
    
    resource = "eks-cluster-node-group"
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
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
        "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
        "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    ]
}

inputs = {
    name = "${include.locals.platform}-${include.locals.host}-${include.locals.env}-${local.resource}-role"
    assume_role_policy = local.assume_role_policy
    managed_policy_arns = local.managed_policy_arns
    tags = include.locals.tags
}