output "arn" {
  value = aws_elasticache_replication_group.redis.arn
  description = "ARN of the ElasticCache"
}

output "primary_endpoint" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_address
}