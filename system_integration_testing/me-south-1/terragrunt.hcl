remote_state {
    backend = "s3"
    config = {
        bucket = "${local.tf_state_bucket}"
        key = "${local.aws_region}/${path_relative_to_include()}/terraform.tfstate"
        skip_bucket_root_access = true
        region = "${local.aws_region}"
        encrypt = true
        skip_bucket_root_access = true
        dynamodb_table = "${local.tf_lock_table}"
    }
    generate = {
        path      = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }
}

locals {
    aws_region = "ap-south-1"
    #aws_region_dr = "eu-west-1"
    env = "sit"
    env_dr = "sit-dr"
    platform = "omega"
    host = "air-asia"
    tf_state_bucket = "${local.prefix}-terraform-backend-state-test-123"
    tf_lock_table = "terraform-backend-lock"
    prefix = "${local.platform}-${local.host}-${local.env}"
    tags = {
        "Environment" = "staging"
        "Owner" = "terraform/terragrunt"
        "Platform-host" = "${local.platform}-${local.host}"
    }
}
generate "provider-aws" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
    provider "aws" {
      region = "${local.aws_region}"
    }
    terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "<= 3.65.0"
        }
      }
    }
  EOF
}
