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

#ECS service
resource "aws_ecs_service" "mongo" {
  name            = "mongodb"
  cluster         = aws_ecs_cluster_capacity_providers.ecs_cluster_capacity_providers.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 3
  iam_role        = aws_iam_role.foo.arn

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.foo.arn
    container_name   = "mongo"
    container_port   = 8080
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}