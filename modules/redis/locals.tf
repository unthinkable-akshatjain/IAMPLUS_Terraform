locals {
  name = "${var.platform}-${var.host}-${var.env}-${var.resource}"
  engine = "redis"
  parameter_group_name = "default.redis3.2"
  port = 6379
  maintenance_window = "sat:00:00-sat:03:00"

  redis_kms_description = "This is to ecrypt the Redis at the rest"
  redis_kms_key_alias_name = "alias/${local.name}"
}