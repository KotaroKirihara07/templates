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

#ECS cluster capacity providers
resource "aws_ecs_cluster_capacity_providers" "ecs_cluster_capacity_providers" {
  cluster_name = aws_ecs_cluster.ecs_cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base = 1
    weight = 100
    capacity_provider = "FARGATE"
  }

  tags = {
    Name = "${var.prefix}_ecs_cluster_capacity_providers"
  }
}

#ECS task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = "${var.prefix}_ecs_family"
  requires_compatibilities = [var.requires_compatibilities]
  network_mode = "awsvpc"
  cpu = 
  memory = 
  task_role_arn = 
  execution_role_arn = 
  container_definitions = jsonencode(var.container_definitions)
}