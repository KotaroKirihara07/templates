#ECS cluster



#ECS cluster capacity providers



#container definitions
requires_compatibilities = "FARGATE"
network_mode = "awsvpc
container_definitions = 
  [
    {
      name      = "first"
      image     = "service-first"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ]




#ECS service