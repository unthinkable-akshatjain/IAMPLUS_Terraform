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

variable "es_version" {
  type = string
  description = "ElasticSearch Version"
}

variable "create_iam_service_linked_role" {
  type = bool
  description = "Whether to create AWSServiceRoleForAmazonElasticsearchService service-linked role."
}

variable "ebs_volume_size" {
  type = number
  description = "EBS volumes for data storage in GB	"
}

variable "worker_node_instance_count" {
  type = number
  description = "Number of data nodes in the cluster"
}

variable "instance_type" {
  type = string
  description = "Instance type of the cluster"
}

variable "iam_role_arn" {
  type = list(string)
  description = "List of IAM role ARNs to permit access to the Elasticsearch domain"
}

variable "username" {
  type = string
  description = "Master Username for the Kibana"
}

variable "password" {
  type = string
  description = "Master Password for the Kibana"
}

variable "custom_endpoint" {
  type = string
  description  = "Fully qualified domain for custom endpoint"
}

variable "acm_arn" {
  type = string
  description = "ACM for the custom endpoint"
}

variable "require_dedicated_master" {
  type = bool
  description = "Dedicated Master node required or not. "
}

variable "required_dedicated_master_count" {
   type = number
   description = "Count of Dedicated Master Nodes to a OpenSearch Cluster."
}

variable "availability_zone_count" {
  type = number
  description = "Count for Required Availability Zone i.e. either 2 or 3 not less than that. "
}

