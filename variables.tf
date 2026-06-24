variable "environment" {
  type        = string
  description = "The target deployment environment (dev or qa)"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}