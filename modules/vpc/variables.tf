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

variable "vpc_cidr" {
  type = string
  description = "The CIDR block for the VPC"
}

variable "azs" {
  type = list
  description = "A list of availability zones names or ids in the region"
}