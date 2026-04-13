# アカウントID (${data.aws_caller_identity.self.account_id})
data "aws_caller_identity" "self" {}


#リージョン (${data.aws_region.current.name})
data "aws_region" "current" {}


# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
      Name = "${var.prefix}_vpc"
    }
}

# public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr_block
  tags = {
    Name = "${var.prefix}_public_subnet"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.prefix}_internet_gateway"
  }
}


# Internet Gateway attachment
resource "aws_internet_gateway_attachment" "igw_attachment" {
  internet_gateway_id = aws_internet_gateway.igw.id
  vpc_id              = aws_vpc.vpc.id
}


# public subnet route table
resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.prefix}_public_subnet_route_table"
  }
}


# public route table association
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet_route_table.id
}


# ECS task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.prefix}_ecs_task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::${data.aws_caller_identity.self.account_id}:role/AmazonECSTaskExecutionRole"
  task_role_arn            = "arn:aws:iam::${data.aws_caller_identity.self.account_id}:role/AmazonECSTaskRole"
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name                    = "Apache-HTTP-Server"
      image                   = "public.ecr.aws/docker/library/httpd:latest"
      operating_system_family = "LINUX"
      cpu                     = 256
      memory                  = 512

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.esc_task_log_group.name
          "awslogs-region"        = "${data.aws_region.current.name}"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

  tags = {
    Name = "${var.prefix}_ecs_task_definition"
  }
}


# ECS service
resource "aws_ecs_service" "ecs_service" {
  name            = "???"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = 3
  iam_role        = "arn:aws:iam::${data.aws_caller_identity.self.account_id}:role/AmazonECSServiceRole"

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  network_configuration {
    subnets          = aws_subnet.public_subnet
    security_groups  = ["aws_security_group.???.id"]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    container_name   = "???"
    container_port   = 80
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [ap-northeast-1a, ap-northeast-1c]"
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


# cloudwatch log group
resource "aws_cloudwatch_log_group" "esc_task_log_group" {
  name              = "${var.prefix}_esc_task_log_group"
  retention_in_days = 7

  tags = {
    Name = "${var.prefix}_esc_task_log_group"
  }
}


# Application Load Balancer
resource "aws_lb" "alb" {
  name               = "${var.prefix}_alb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.test.id]
  subnets = [aws_subnet.public_subnet.id]
  ip_address_type = "ipv4"

  tags = {
    Name = "${var.prefix}_alb"
  }
}


# ALBターゲットグループ
resource "aws_lb_target_group" "lb_target_group" {
  name             = "${var.prefix}_lb_target_group"
  target_type      = "ip"
  protocol_version = "HTTP1"
  port             = 80
  protocol         = "HTTP"
  vpc_id = aws_vpc.vpc.id

  health_check {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200,301"
  }

  tags = {
    Name = "${var.prefix}_lb_target_group"
  }
}


# ALBターゲットグループをコンテナにアタッチする
resource "aws_lb_target_group_attachment" "lb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = "???".id
}


# ALBリスナー
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }

  tags = {
    Name = "${var.prefix}_lb_listener"
  }
}
