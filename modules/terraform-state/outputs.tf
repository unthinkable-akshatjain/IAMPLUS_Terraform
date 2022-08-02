output "tf-backenc-kms-key-arn" {
  value       = aws_kms_key.tf-backend-state-key.arn
  description = "KMS key ARN for terraform backend state"
}

output "tf-backend-kms-key-alias-arn" {
  value       = aws_kms_alias.tf-backend-state-key-alias.arn
  description = "KMS key alias ARN for terraform backend state"
}

output "tf-backend-bucket-name" {
  value = local.s3_bucket_name
  description = "Terraform Backend state bucket name"
}

output "tf-backend-bucket-arn" {
  value = aws_s3_bucket.terraform-backend-state.arn
  description = "Terraform backend state bucket ARN"
}

output "tf-backend-lock-table-name" {
  value = local.dynamodb_table_name
  description = "Terraform backend state lock table name"
}

output "tf-backend-lock-table-arn" {
  value = aws_dynamodb_table.terraform-backend-lock.arn
  description = "Terraform backend state lock table ARN"
}