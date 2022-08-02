locals {
  vpc_prefix = "${var.platform}-${var.host}-${var.env}"

  private_subnets = [cidrsubnet(var.vpc_cidr,3, 0), cidrsubnet(var.vpc_cidr,3, 1), cidrsubnet(var.vpc_cidr,3, 2)]
  public_subnets = [cidrsubnet(var.vpc_cidr,4, 6), cidrsubnet(var.vpc_cidr,4, 7), cidrsubnet(var.vpc_cidr,4, 8)]
  database_subnets = [cidrsubnet(var.vpc_cidr,4,9), cidrsubnet(var.vpc_cidr,4,10), cidrsubnet(var.vpc_cidr,4,11)]
}