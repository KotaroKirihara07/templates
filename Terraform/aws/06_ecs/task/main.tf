# アカウントID (${data.aws_caller_identity.self.account_id})
data "aws_caller_identity" "self" {}


#リージョン (${data.aws_region.current.name})
data "aws_region" "current" {}


# vpc
module "vpc" {
  source = "./modules/vpc"

  prefix = var.prefix
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
}


# cloudwatch
module "cloudwatch" {
  source = "./modules/cloudwatch"

  prefix = var.prefix
  retention_in_days = var.retention_in_days
}


# ecs task
module "ecs_task" {
  source = "./modules/ecs-task"

  prefix = var.prefix
  account_id = data.aws_caller_identity.self.account_id
  region = data.aws_region.current.name
  task_definition_name = "hello-world"
  image_name = "public.ecr.aws/docker/library/hello-world:latest"
  log_group_name = module.cloudwatch.log_group_name
}