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

variable "cluster_endpoint_public_access_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
}

# aws-auth config map
variable "map_users" {
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  description = "List of users object to be permitted to EKS"
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}

variable "map_accounts" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)

  default = [
    "541045388833",
  ]
}

# IAM 
variable "cluster_iam_role_name" {
  type = string
  description = "AM role name for the cluster"
}

# Managed Node Groups
variable "node_groups" {
  type = map
  description = "Managed Node Groups for the EKS"
}