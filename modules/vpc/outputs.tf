output "vpc_name" {
  value = local.vpc_prefix
  description = "The name of the VPC specified as argument to this module"
}

output "vpc_id" {
  value = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "vpc_cidr" {
  value = var.vpc_cidr
  description = "The CIDR of VPC"
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.vpc.database_subnets
}

output "default_security_group_id" {
  value = module.vpc.default_security_group_id
  description = "The ID of the security group created by default on VPC creation default_vpc_arn"
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = "${aws_eip.nat.*.public_ip}"
}

output "public_route_table_ids" {
  value = module.vpc.public_route_table_ids
  description = "List of IDs of public route tables"
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
  description = "List of IDs of private route tables"
}

output "database_route_table_ids" {
  value = module.vpc.database_route_table_ids
  description = "List of IDs of database route tables"
}