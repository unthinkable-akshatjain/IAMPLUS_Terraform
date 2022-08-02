module "eks-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  
  create_eks = true
  cluster_name = local.cluster_name
  cluster_version = local.cluster_version
  enable_irsa = true

  subnets = var.subnets
  vpc_id = var.vpc_id
  cluster_egress_cidrs = [var.vpc_cidr]

  cluster_endpoint_public_access = true
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  cluster_endpoint_private_access = true
  cluster_endpoint_private_access_cidrs = [var.vpc_cidr]
  cluster_create_endpoint_private_access_sg_rule = true
  cluster_encryption_config = [
    {
      provider_key_arn = aws_kms_key.secret_eks_key.arn
      resources        = ["secrets"]
    }
  ]

  cluster_iam_role_name = var.cluster_iam_role_name
  manage_cluster_iam_resources = false
  manage_worker_iam_resources = false

  map_roles    = var.map_roles
  map_users    = var.map_users
  map_accounts = var.map_accounts
  
  cluster_enabled_log_types = ["api","audit","authenticator","controllerManager","scheduler"]
  cluster_log_kms_key_id = aws_kms_key.logs_eks_key.arn

  node_groups = var.node_groups

  tags = var.tags
}

data "aws_eks_cluster" "cluster" {
  name = module.eks-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks-cluster.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}