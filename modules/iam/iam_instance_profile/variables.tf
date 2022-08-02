variable "name" {
  type        = string
  description = "Friendly name of the role"
}

variable "role_arn" {
  type = string
  description = "ROLE ARN"
}

variable "tags" {
  type        = map(string)
  description = "Key-value mapping of tags for the IAM role"
}
