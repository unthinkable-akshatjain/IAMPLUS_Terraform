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

variable "public_key" {
  type = string
  description = "Public Key to generate the Key Pait on EC2"
}

variable "resource" {
  type = string
  description = "Name of the resouce for which you need to make keypair"
}

locals {
  kp_prefix = "${var.platform}-${var.host}-${var.env}"
}