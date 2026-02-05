# アカウントID (${data.aws_caller_identity.self.account_id})
data "aws_caller_identity" "self" {}


# ZIPファイルアーカイブ
data "archive_file" "lambda_zip_file" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/src"
  output_path = "${path.module}/lambda/upload/function.zip"
}


# Lambda関数
resource "aws_lambda_function" "lambda_function" {
  filename         = "${data.archive_file.lambda_zip_file.output_path}"
  function_name    = "${var.prefix}_${var.function_name}"
  role             = "arn:aws:iam::${data.aws_caller_identity.self.account_id}:role/Lambda-ExecutionRole"
  handler          = "main.lambda_handler"
  source_code_hash = "${data.archive_file.lambda_zip_file.output_base64sha256}"
  runtime          = "python3.11"
  package_type  = "Zip"
  memory_size = 128
  timeout     = 30

  logging_config {
    log_format = "JSON"
    log_group  = aws_cloudwatch_log_group.lambda_log_group.name
  }

  depends_on = [
    aws_cloudwatch_log_group.lambda_log_group
  ]

  tags = {
    Name = "${var.prefix}_${var.function_name}"
  }
}


# cloudwatch log group
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.prefix}_${var.function_name}"
  retention_in_days = 7

  tags = {
    Name = "/aws/lambda/${var.prefix}_${var.function_name}"
  }
}