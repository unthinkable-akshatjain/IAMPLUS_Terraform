output "kms_arn" {
  value = aws_kms_key.kms_key.arn
}

output "kms_key_id" {
  value = aws_kms_key.kms_key.key_id
}