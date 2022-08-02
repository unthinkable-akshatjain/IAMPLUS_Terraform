locals {  
  s3_bucket_name = "${var.platform}-${var.host}-${var.env}-${var.resource}"
  s3_bucket_acl = "private"
}