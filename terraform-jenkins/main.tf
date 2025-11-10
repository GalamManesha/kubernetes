provider "aws" {
  region = var.aws_region
}

# 3 EC2 Instances
resource "aws_instance" "my_ec2" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "${var.project_name}-ec2-${count.index + 1}"
  }
}

# 1 S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.project_name}-terraform-bucket"

  tags = {
    Name = "Terraform S3 Bucket"
  }
}
