variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "ami_id" {
  description = "AMI ID to use"
  type        = string
  default     = "ami-0c398cb65a93047f2" 
}
variable "key_name" {
  description = "key name"
  type        = string
  default     = "North" 
}
