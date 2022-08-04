terraform {
  backend "s3" {
    bucket         = "terraform-backend-state-test-456"
    dynamodb_table = "terraform-backend-lock-test-456"
    encrypt        = true
    key            = "ap-south-1/./terraform.tfstate"
    region         = "ap-south-1"
  }
}
