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
      ENV_VAR1 = "production"
      ENV_VAR2 = "info"
      ENV_VAR3 = 100
    }
  }

  tags = {
    Name = "${var.prefix}_lambda_function"
  }
}
