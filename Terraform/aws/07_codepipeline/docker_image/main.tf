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


# CodePipline
resource "aws_codepipeline" "codepipeline" {
  name           = "${var.prefix}_codepipeline"
  execution_mode = "QUEUED"
  pipeline_type  = "V2"
  role_arn       = "arn:aws:iam::${data.aws_caller_identity.self.account_id}:role/service-role/AWSCodePipelineServiceRole-${data.aws_region.current.name}-${var.prefix}_codepipeline"
  
  artifact_store {
    location = "codepipeline-${data.aws_region.current.name}-${data.aws_caller_identity.self.account_id}"
    region   = "${data.aws_region.current.name}"
    type     = "S3"
  }
  
  stage {
    name = "Source"
    action {
      category = "Source"
      configuration = {
        BranchName           = "main"
        OutputArtifactFormat = "CODE_ZIP"
        PollForSourceChanges = "false"
        RepositoryName       = "${var.prefix}_codecommit_repository"
      }
      name               = "Source"
      namespace          = "SourceVariables"
      output_artifacts   = ["SourceArtifact"]
      owner              = "AWS"
      provider           = "CodeCommit"
      region             = "${data.aws_region.current.name}"
      role_arn           = null
      run_order          = 1
      version            = "1"
    }
    on_failure {
      result = "RETRY"
      retry_configuration {
        retry_mode = "ALL_ACTIONS"
      }
    }
  }

  stage {
    name = "Build"
    action {
      category = "Build"
      configuration = {
        ProjectName = "${var.prefix}_codebuild_project"
      }
      input_artifacts    = ["SourceArtifact"]
      name               = "Build"
      namespace          = "BuildVariables"
      output_artifacts   = ["BuildArtifact"]
      owner              = "AWS"
      provider           = "CodeBuild"
      region             = "${data.aws_region.current.name}"
      role_arn           = null
      run_order          = 1
      version            = "1"
    }
    on_failure {
      result = "RETRY"
      retry_configuration {
        retry_mode = "ALL_ACTIONS"
      }
    }
  }

  tags = {
    Name = "${var.prefix}_codepipeline"
  }
}