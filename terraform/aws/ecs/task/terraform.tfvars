#ECS cluster



#ECS cluster capacity providers




#container definitions
requires_compatibilities = "FARGATE"
network_mode = "awsvpc"
container_definitions = 
  [
    {
      name      = "first"
      image     = "service-first"
      cpu       = 1
      memory    = 2
      essential = true
    }
  ]