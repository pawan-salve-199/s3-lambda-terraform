resource "aws_s3_bucket" "s3_bucket_demo" {
  bucket = "my-tf-test-bucket${var.environment}-221"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}