variable "env" {
  type        = string
  description = "Environment in short."
}

variable "platform" {
  type        = string
  description = "Platform for the application."
}

variable "host" {
  type        = string
  description = "Host for the application."
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "tags" {
  type        = map(string)
  description = "Default Tags for the resources"
}

variable "resource" {
  type        = string
  description = "Resource which you are creating"
}

# Networking
variable "vpc_id" {
  type        = string
  description = "VPC ID under which we need the EKS Cluster"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block of VPC"
}

variable "database_subnets" {
  type        = list(string)
  description = "A list of VPC subnet IDs"
}

variable "monitoring_role_arn" {
  type        = string
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
}

variable "username" {
  type        = string
  description = "Username for the database"
}

variable "password" {
  type        = string
  description = "Password for the database"
}
