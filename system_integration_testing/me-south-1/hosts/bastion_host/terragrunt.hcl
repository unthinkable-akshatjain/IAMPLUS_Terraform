include {
  path = find_in_parent_folders()
  expose = true
}

terraform{
    source = "../../../modules//bastion_host//"
}

dependency "vpc" {
    config_path = "../../vpc"
}

dependency "key_pair" {
    config_path = "../../key_pairs/bastion_host"
}

dependency "iam_role" {
    config_path = "../../iam/instance_profiles/omega-air-asia-sit-bastion-instance-profile"
}

locals {
  all_include = read_terragrunt_config(find_in_parent_folders("envs/security_group_ingress.hcl"))
  resource = "bastion"
  ami_owners = ["amazon"]
  ami_name = ["amzn2-ami-hvm-2.0.20220426.0-x86_64-gp2"]
  volume_size = 30
  instance_type = "t3.medium"
  ingress_sg = local.all_include.locals.ingress
  egress_sg = local.all_include.locals.egress
}

inputs = {
    
    env = include.locals.env
    platform = include.locals.platform
    host = include.locals.host
    region = include.locals.aws_region
    tags = include.locals.tags
    resource = local.resource
    ami_owners = local.ami_owners
    iam_role = dependency.iam_role.outputs.profile_name
    ami_name = local.ami_name
    instance_type = local.instance_type
    key_name = dependency.key_pair.outputs.key_name
    volume_size = local.volume_size
    vpc_id = dependency.vpc.outputs.vpc_id
    subnet_id = dependency.vpc.outputs.public_subnets[0]
    vpc_default_sg = dependency.vpc.outputs.default_security_group_id
    ingress_rules = local.ingress_sg
    egress_rules = local.egress_sg
}
