resource "aws_dynamodb_table" "terraform-backend-lock" {
  name           = local.dynamodb_table_name
  read_capacity  = local.dynamodb_table_read_capacity
  write_capacity = local.dynamodb_table_write_capacity
  hash_key       = local.dynamodb_table_key
  billing_mode   = "PAY_PER_REQUEST"
  attribute {
    name = local.dynamodb_table_key
    type = "S"
  }
}
