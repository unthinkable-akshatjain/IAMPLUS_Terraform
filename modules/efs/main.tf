module "efs" {
  source = "cloudposse/efs/aws"
 
  enabled = true

  namespace       = local.namespace
  stage           = "test"
  name            = local.name
  region          = var.region
  vpc_id          = var.vpc_id
  subnets         = var.subnets
  security_groups = [module.efs_security_group.security_group_id]

  encrypted = true
  kms_key_id =  aws_kms_key.efs_key.arn

  tags = var.tags
}