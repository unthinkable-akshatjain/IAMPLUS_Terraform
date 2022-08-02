include {
  path = find_in_parent_folders()
  expose = true
}

terraform {
    source = "../../../../modules//eks//"
}

dependency "vpc" {
    config_path = "../../vpc"
}

dependency "cluster_role"{
    config_path = "../../iam/iam_roles/omega-air-asia-sit-eks-cluster-role"
}

dependency "node_group_role" {
    config_path = "../../iam/iam_roles/omega-air-asia-sit-eks-cluster-node-group-role"
}

dependency "bastion_role" {
    config_path = "../../iam/iam_roles/omega-air-asia-sit-bastion-role"
}

dependency "node_group_volume_key" {
    config_path = "../../kms/omega-air-asia-sit-eks-cluster-node-group-volume-key"
}

locals {
    resource = "eks-cluster"
    aws_id = "681257129225"
    public_cidrs = ["14.141.28.114/32", "157.175.10.116/32"]

    users = [ 
        {
            groups = ["system:masters"]
            userarn = "arn:aws:iam::681257129225:user/shubham-daffodil"
            username = "shubham-daffodil"
        },
        {
            groups = ["system:masters"]
            userarn = "arn:aws:iam::681257129225:user/Yashika-Daffodil"
            username = "yashika-daffodil"
        }
    ]
}

inputs = {
    env = include.locals.env
    platform = include.locals.platform
    host = include.locals.host
    region = include.locals.aws_region
    tags = include.locals.tags
    resource = local.resource
    aws_id = local.aws_id
    subnets = dependency.vpc.outputs.private_subnets
    vpc_id = dependency.vpc.outputs.vpc_id
    vpc_cidr = dependency.vpc.outputs.vpc_cidr
    cluster_endpoint_public_access_cidrs = concat(formatlist("%s/32", dependency.vpc.outputs.nat_public_ips), local.public_cidrs)
    map_accounts = ["${local.aws_id}"]
    map_users = local.users
    map_roles = [
        {
        rolearn  = "${dependency.bastion_role.outputs.role_arn}"
        username = "bastion"
        groups   = ["system:masters"]
        }
    ]
    cluster_iam_role_name = dependency.cluster_role.outputs.role_name

    node_groups = {
        services = {
            name = "${include.locals.platform}-${include.locals.host}-${include.locals.env}-${local.resource}-services"
            iam_role_arn = "${dependency.node_group_role.outputs.role_arn}"
            max_capacity     = 10
            desired_capacity = 1
            min_capacity     = 1
            // ami_id = "ami-01deff6d1b3a33e82"
            // ami_is_eks_optimized = false
            ami_type = "AL2_x86_64"
            instance_types = ["m5.xlarge"]
            capacity_type  = "ON_DEMAND"
            k8s_labels = {
                Environment = "staging"
                NodeGroupType = "services"
            }
            additional_tags = {
                NodeGroupType = "services"
            }
            taints = [
                {
                key    = "dedicated"
                value  = "services"
                effect = "NO_SCHEDULE"
                }
            ]
            update_config = {
                max_unavailable = 2
            }
            subnets = dependency.vpc.outputs.private_subnets
            create_launch_template = true
            disk_encrypted = true
            disk_kms_key_id = "${dependency.node_group_volume_key.outputs.kms_arn}"
            disk_size = 50
            enable_monitoring = true
        }
        instrumentation = {
            name = "${include.locals.platform}-${include.locals.host}-${include.locals.env}-${local.resource}-instrumentation"
            iam_role_arn = "${dependency.node_group_role.outputs.role_arn}"
            max_capacity     = 9
            desired_capacity = 3
            min_capacity     = 1
            // ami_id = "ami-01deff6d1b3a33e82"
            // ami_is_eks_optimized = false
            ami_type = "AL2_x86_64"
            instance_types = ["m5.xlarge"]
            capacity_type  = "ON_DEMAND"
            k8s_labels = {
                Environment = "staging"
                NodeGroupType = "instrumentation"
            }
            additional_tags = {
                NodeGroupType = "instrumentation"
            }
            taints = [
                {
                key    = "dedicated"
                value  = "instrumentation"
                effect = "NO_SCHEDULE"
                }
            ]
            update_config = {
                max_unavailable = 2
            }
            subnets = dependency.vpc.outputs.private_subnets
            create_launch_template = true
            disk_encrypted = true
            disk_kms_key_id = "${dependency.node_group_volume_key.outputs.kms_arn}"
            disk_size = 50
            enable_monitoring = true
        }
        summarization = {
            name = "${include.locals.platform}-${include.locals.host}-${include.locals.env}-${local.resource}-summarization"
            iam_role_arn = "${dependency.node_group_role.outputs.role_arn}"
            max_capacity     = 10
            desired_capacity = 1
            min_capacity     = 1
            // ami_id = "ami-087e5263dc0c85a26"
            // ami_is_eks_optimized = false
            ami_type = "AL2_x86_64_GPU"
            instance_types = ["g4dn.xlarge"]
            capacity_type  = "ON_DEMAND"
            k8s_labels = {
                Environment = "staging"
                NodeGroupType = "summarization"
                nvidia-device-plugin-g4= true
            }
            additional_tags = {
                NodeGroupType = "summarization"
            }
            taints = [
                {
                key    = "dedicated"
                value  = "summarization"
                effect = "NO_SCHEDULE"
                }
            ]
            update_config = {
                max_unavailable = 1
            }
            subnets = dependency.vpc.outputs.private_subnets
            create_launch_template = true
            disk_encrypted = true
            disk_kms_key_id = "${dependency.node_group_volume_key.outputs.kms_arn}"
            disk_size = 50
            enable_monitoring = true
        }
    }
}