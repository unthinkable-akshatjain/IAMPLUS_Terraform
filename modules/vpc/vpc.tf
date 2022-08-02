resource "aws_eip" "nat" {
  count = 3
  vpc   = true
  tags = var.tags
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpc_prefix
  cidr = var.vpc_cidr

  azs                = var.azs
  enable_vpn_gateway = false

  public_subnets   = local.public_subnets
  private_subnets  = local.private_subnets
  database_subnets = local.database_subnets

  enable_dns_hostnames = true
  enable_dns_support = true

  one_nat_gateway_per_az = true
  enable_nat_gateway     = true
  single_nat_gateway     = false
  reuse_nat_ips          = true
  external_nat_ip_ids    = aws_eip.nat.*.id

  enable_flow_log                                 = true
  create_flow_log_cloudwatch_iam_role             = true
  create_flow_log_cloudwatch_log_group            = true
  flow_log_cloudwatch_log_group_retention_in_days = "30"
  flow_log_cloudwatch_log_group_name_prefix       = "/aws/${local.vpc_prefix}-vpc-flow-log/"

  public_subnet_tags = {
    Name                                                    = "${local.vpc_prefix}-public-subnet"
    "kubernetes.io/cluster/${local.vpc_prefix}-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                                = 1
  }

  private_subnet_tags = {
    Name                                                    = "${local.vpc_prefix}-private-subnet"
    "kubernetes.io/cluster/${local.vpc_prefix}-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"                       = 1
  }

  database_subnet_tags = {
    Name                                                    = "${local.vpc_prefix}-private-db-subnet"
    "kubernetes.io/cluster/${local.vpc_prefix}-eks-cluster" = "shared"
  }

  database_subnet_group_tags = {
    Name = "${local.vpc_prefix}-private-db-subnet-group"
  }

  private_route_table_tags = {
    Name = "${local.vpc_prefix}-private-rt"
  }

  public_route_table_tags = {
    Name = "${local.vpc_prefix}-public-rt"
  }

  nat_gateway_tags = {
    Name = "${local.vpc_prefix}-nat"
  }

  igw_tags = {
    Name = "${local.vpc_prefix}-igw"
  }

  database_route_table_tags = {
    Name = "${local.vpc_prefix}-private-db-rt"
  }

  nat_eip_tags = {
    Name = "${local.vpc_prefix}-nat-eip"
  }

  tags = merge({
    "kubernetes.io/cluster/${local.vpc_prefix}-eks-cluster" = "shared"
  },var.tags)

}
