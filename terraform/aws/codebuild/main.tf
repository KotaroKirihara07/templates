resource "aws_codebuild_project" "codebuild_project" {
  name          = "test-project"
  service_role  = aws_iam_role.example.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    type                        = "LINUX_CONTAINER"
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    environment_variable [
      {
        name  = "REGION",
        value = "ap-northeast-1"
      },
      {
        name = "ACCOUNT"
        value = "123456789012"
      },
      {
        name  = "IMAGE_REPO_NAME"
        value = "repo_name"
      },
      {
        name  = "IMAGE_TAG"
        value = "latest"
      }
    ]
  }

  source {
    type            = "S3"
    location        = "bucket_name/key_name/source.zip"
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  buildspec = "./buildspec.yml"

  tags = {
    Name = "${var.prefix}_codebuild_project"
  }
}