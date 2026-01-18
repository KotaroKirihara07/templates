resource "aws_lambda_function" "example" {
  function_name = "example_container_function"
  role          = aws_iam_role.example.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.example.repository_url}:latest"

  image_config {
    entry_point = ["/lambda-entrypoint.sh"]
    command     = ["app.handler"]
  }

  memory_size = 512
  timeout     = 30

  architectures = ["arm64"] # Graviton support for better price/performance
}