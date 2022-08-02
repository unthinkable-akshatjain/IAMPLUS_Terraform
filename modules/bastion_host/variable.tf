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
  description = "The resource you are going to create"
}

variable "ami_owners" {
  type        = list
  description = "Owner of the AMI"
}

variable "ami_name" {
  type        = list
  description = "AMI Name for filteration"
}

variable "instance_type" {
  type        = string
  description = "AWS Instance Type for the host"
}

variable "key_name" {
  type        = string
  description = "Key name of the Key Pair to use for the instance"
}

variable "volume_size" {
  type = number
  description = "Size of the root volume"
}

variable "vpc_id" {
  type = string
  description = "VPC ID for the host machine"
}

variable "subnet_id" {
  type = string
  description = "Subnet ID to attach with"
}

variable "vpc_default_sg" {
  type        = string
  description = "security group ID to associate with"
}

variable "ingress_rules" {
  type = list
}

variable "iam_role" {
  type = string
  description = "IAM Role for the bastion"
}