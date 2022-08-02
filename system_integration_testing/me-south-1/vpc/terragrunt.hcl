include {
  path = find_in_parent_folders()
  expose = true
}

terraform {
    source = "../../../modules//vpc//"
}

locals {
    cidr = "10.100.0.0/19"
    azs = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

inputs = {
    env = include.locals.env
    platform = include.locals.platform
    host = include.locals.host
    region = include.locals.aws_region
    tags = include.locals.tags
    vpc_cidr = local.cidr
    azs = local.azs
}