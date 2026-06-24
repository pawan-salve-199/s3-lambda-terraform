# 1. S3 Landing Bucket
resource "aws_s3_bucket" "landing_bucket" {
  bucket        = "my-landing-bucket-${var.environment}-unique999" 
  force_destroy = true
}

# 2. Build the final trigger rule linking S3 to Lambda
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.landing_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_processor.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3]
}