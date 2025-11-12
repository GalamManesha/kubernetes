terraform {
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.aws_region
  # Credentials will be provided via environment variables in Jenkins (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)
}
