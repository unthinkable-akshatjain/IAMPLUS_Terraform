include {
  path = find_in_parent_folders()
  expose = true
}

terraform {
    source = "../../../../modules/iam//iam_instance_profile//"
}

dependency "bastion-role" {
    config_path = "../../iam_roles/omega-air-asia-sit-bastion-role"
}

locals {
    resource = "bastion"
}

inputs = {
    name = "${include.locals.platform}-${include.locals.host}-${include.locals.env}-${local.resource}-instance-profile"
    role_arn = dependency.bastion-role.outputs.role_name
    tags = include.locals.tags
}
