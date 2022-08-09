terraform {
    source = "../../../modules//terraform-state//"
}

locals {
    env_name = "sit"
    platform_name = "omega"
    host_name = "air-asia"
    aws_region = "ap-south-1"
    tags = {
        "Environment" = "staging"
        "Owner" = "terraform/terragrunt"
        "Platform-host" = "omega-air-asia"
    }
}

inputs = {
    region = local.aws_region
    env = local.env_name
    platform = local.platform_name
    host = local.host_name
    tags = local.tags
}
