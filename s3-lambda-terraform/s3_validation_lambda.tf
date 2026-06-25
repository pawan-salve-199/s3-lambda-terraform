# 1. Automatically zip up your Python code folder
data "archive_file" "lambda_validation_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../src"
  output_path = "${path.module}/Lambda_validation.zip"
}

# 2. Define the Lambda Function in AWS
resource "aws_lambda_function" "s3_lambda_validation" {
  filename         = data.archive_file.lambda_validation_zip.output_path
  function_name    = "s3-file-validation-${var.environment}"
  role             = aws_iam_role.lambda_role.arn
  handler          = "Lambda_validation.lambda_handler"
  runtime          = "python3.11"
  source_code_hash = data.archive_file.lambda_validation_zip.output_base64sha256
}

# 3. Explicitly allow your S3 bucket to wake up your Lambda function
resource "aws_lambda_permission" "allow_validation_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_lambda_validation.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.landing_bucket.arn
}