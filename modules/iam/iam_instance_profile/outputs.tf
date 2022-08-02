output "profile_arn" {
  value       = aws_iam_instance_profile.iam_instance_profile.arn
  description = "Amazon Resource Name (ARN) specifying the instnace_profile"
}

output "profile_name" {
  value = aws_iam_instance_profile.iam_instance_profile.name
}
