output "db_instance_arn" {
  value = module.master.db_instance_arn
  description = "The ARN of the RDS instance"
}

output "db_instance_id" {
  value = module.master.db_instance_id
  description = "The RDS instance ID"
}

output "db_instance_name" {
  value = module.master.db_instance_name
  description = "The database name"
}