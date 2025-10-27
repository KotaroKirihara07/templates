#ECS task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = "${var.prefix}_ecs_task"
  network_mode = var.network_mode
  requires_compatibilities = [var.requires_compatibilities]
  execution_role_arn = "arn:aws:iam::123456789012:role/AmazonECSTaskExecutionRole"
  task_role_arn = "arn:aws:iam::123456789012:role/AmazonECSTaskRole"
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([
    {
      name      = "hello-world"
      image     = "123456789012.dkr.ecr.ap-northeast-1.amazonaws.com/hello-world:latest"
      operating_system_family = "LINUX"
      cpu       = 1024
      memory    = 2048

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group" = aws_cloudwatch_log_group.esc_task_log_group.name
          "awslogs-region" = "ap-northeast-1" 
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

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

resource "aws_cloudwatch_log_group" "esc_task_log_group" {
  name = "/ecs/${var.prefix}_ecs_task"
  retention_in_days = 7
}