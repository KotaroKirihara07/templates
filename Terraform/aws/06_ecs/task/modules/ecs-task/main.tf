# ECS task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.prefix}_ecs_task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::${var.account_id}:role/AmazonECSTaskExecutionRole"
  task_role_arn            = "arn:aws:iam::${var.account_id}:role/AmazonECSTaskRole"
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name                    = var.task_definition_name
      image                   = var.image_name
      operating_system_family = "LINUX"
      cpu                     = 256
      memory                  = 512

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.log_group_name
          "awslogs-region"        = "${var.region}"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

  tags = {
    Name = "${var.prefix}_ecs_task_definition"
  }
}


# ECS cluster
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