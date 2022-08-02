variable "tags" {
  type = map(string)
  description = "Tags for the resource"
}

variable "kms_description" {
  type = string
  description = "Description for the KMS Key"
}

variable "kms_key_alias_name" {
    type = string
    description = "Alias for the KMS Key"
}

variable "policy" {
  type = string
  description = "Policy for the KMS Key"
}