# アカウントID (${data.aws_caller_identity.self.account_id})
data "aws_caller_identity" "self" {}


#リージョン (${data.aws_region.current.name})
data "aws_region" "current" {}


# ECR (private ECR repository)
resource "aws_ecr_repository" "ecr_repository" {
  name                 = "${var.prefix}_ecr_repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.prefix}_ecr_repository"
  }
}


# codecommit repository
resource "aws_codecommit_repository" "codecommit_repository" {
  repository_name = "${var.prefix}_codecommit_repository"

  tags = {
    Name = "${var.prefix}_codecommit_repository"
  }
}


# CodeBuild project
resource "aws_codebuild_project" "codebuild_project" {
  name          = "${var.prefix}_codebuild_project"
  service_role  = "arn:aws:iam::${data.aws_caller_identity.self.account_id}:role/CodeCommit-ExecutionRole"

  environment {
    type                        = "LINUX_CONTAINER"
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
  
    environment_variable {
      name = "ACCOUNT"
      value = "${data.aws_caller_identity.self.account_id}"
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "REGION"
      value = "${data.aws_region.current.name}"
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = "${var.prefix}_codecommit_repository"
      type  = "PLAINTEXT"
    }

    environment_variable {
      name  = "IMAGE_TAG"
      value = "alpine:latest"
      type  = "PLAINTEXT"
    }
  }

  source {
    type            = "CODECOMMIT"
    location = aws_codecommit_repository.codecommit_repository.clone_url_http
    buildspec       = "./buildspec.yml"
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.prefix}_codebuild_project_log_group"
    }
  }

  tags = {
    Name = "${var.prefix}_codebuild_project"
  }
}


# cloudwatch log group
resource "aws_cloudwatch_log_group" "codebuild_project_log_group" {
  name              = "${var.prefix}_codebuild_project_log_group"
  retention_in_days = 7

  tags = {
    Name = "${var.prefix}_codebuild_project_log_group"
  }
}

/*
# CodePipline
resource "aws_codepipeline" "codepipeline" {
  name     = "tf-test-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"

    encryption_key {
      id   = data.aws_kms_alias.s3kmskey.arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.example.arn
        FullRepositoryId = "my-organization/example"
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "test"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CloudFormation"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ActionMode     = "REPLACE_ON_FAILURE"
        Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
        OutputFileName = "CreateStackOutput.json"
        StackName      = "MyStack"
        TemplatePath   = "build_output::sam-templated.yaml"
      }
    }
  }
}


data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name               = "test-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.codepipeline_bucket.arn,
      "${aws_s3_bucket.codepipeline_bucket.arn}/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]

    resources = ["*"]
  }
}
*/