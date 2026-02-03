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
      name                    = "hello-world"
      image                   = "public.ecr.aws/docker/library/hello-world:latest"
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