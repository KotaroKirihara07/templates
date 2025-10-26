#タスクロール
resource "aws_iam_instance_profile" "ecs_task_role" {
  name = "ecs_task_role"
  role = "AmazonECSTaskRole"
}


#タスク実行ロール
resource "aws_iam_instance_profile" "ecs_taskexcute_role" {
  name = "ecs_taskexcute_role"
  role = "AmazonECSTaskExecutionRole"
}


#ECS task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = "${var.prefix}_ecs_family"
  requires_compatibilities = [var.requires_compatibilities]
  task_role_arn = aws_iam_instance_profile.ecs_task_role.arn
  execution_role_arn = aws_iam_instance_profile.ecs_taskexcute_role.arn
  container_definitions = jsonencode(var.container_definitions)

  tags = {
    Name = "${var.prefix}_ecs_task_definition"
  }
}

#ECS cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.prefix}_ecs_cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.prefix}_ecs_cluster"
  }
}