locals {
  kms_description = "This Key is used to encrypt the terraform backend state objects."
  kms_key_alias_name = "alias/terraform-backend-state-key"

  s3_bucket_name = "${var.platform}-${var.host}-${var.env}-terraform-backend-state"
  s3_bucket_acl = "private"

  dynamodb_table_name = "${var.platform}-${var.host}-${var.env}-terraform-backend-lock"
  dynamodb_table_read_capacity = 20
  dynamodb_table_write_capacity = 20
  dynamodb_table_key = "LockID"
}