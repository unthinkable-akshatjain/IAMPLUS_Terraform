resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = local.name
  replication_group_description = "Terraform-managed ElastiCache replication group for ${local.name}"

  number_cache_clusters         = var.num_cache_nodes
  node_type                     = var.node_type

  automatic_failover_enabled    = true
  auto_minor_version_upgrade    = true
  
  # availability_zones            = var.azs
  # multi_az_enabled              = true
  
  engine                        = "redis"
  
  at_rest_encryption_enabled    = true
  kms_key_id                    = aws_kms_key.redis_key.arn
  
  engine_version                = var.engine_version
  port                          = local.port
  
  subnet_group_name             = aws_elasticache_subnet_group.redis_subnet_group.id
  security_group_ids            = [aws_security_group.redis_security_group.id]
  
  maintenance_window            = local.maintenance_window
  
  tags = var.tags

}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "${local.name}-subnet-group"
  subnet_ids = var.database_subnets
}