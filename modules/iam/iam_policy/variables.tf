variable "name" {
  type = string
  description = "The name of the policy"
}

variable "description" {
  type = string
  description = "The description of the policy"
}

variable "policy" {
  type = string
  description = "Policy"
}

variable "tags" {
  description = "Tags"
  type = map(string)
}