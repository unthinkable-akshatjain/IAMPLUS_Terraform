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
variable "subnets" {
  type        = list(string)
  description = "VPC private subnets"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID under which we need the EKS Cluster"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block of VPC"
}