output "sns_arn" {
  value = aws_sns_topic.sns_topic.arn
}

output "sns_id" {
  value = aws_sns_topic.sns_topic.id
}