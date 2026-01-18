# Lambda関数
resource "aws_lambda_function" "lambda_function" {
  filename         = data.archive_file.example.output_path
  function_name    = "example_lambda_function"
  role             = aws_iam_role.example.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.example.output_base64sha256
  runtime = "nodejs20.x"

  environment {
    variables = {
      ENVIRONMENT = "production"
      LOG_LEVEL   = "info"
    }
  }

  tags = {
    Name = "${var.prefix}_lambda_function"
  }
}


# Package the Lambda function code
data "archive_file" "example" {
  type        = "zip"
  source_file = "./lambda/index.js"
  output_path = "./lambda/function.zip"
}