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

variable "node_type" {
  type = string
  description = "The instance class used"
}

variable "num_cache_nodes" {
  type = number
  description = "The initial number of cache nodes that the cache cluster will have. For Redis, this value must be 1"
}

variable "engine_version" {
  type = string
  description = "Version number of the cache engine to be used."
}

# Networking
variable "azs" {
  type = list(string)
  description = "vailability Zone for the cache cluster. If you want to create cache nodes in multi-az"
}

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
