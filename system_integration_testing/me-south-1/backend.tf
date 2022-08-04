terraform {
  backend "s3" {
    bucket         = "terraform-backend-test"
    dynamodb_table = "terraform-backend-lock"
    encrypt        = true
    key            = "ap-south-1/./terraform.tfstate"
    region         = "ap-south-1"
  }
}
