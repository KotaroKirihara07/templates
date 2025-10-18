#ECS cluster



#ECS cluster capacity providers



#container definitions
variable "container_definitions" {
    type = string
    description = "container definitions"
}

variable "requires_compatibilities" {
    type = string
    description = "EC2 or FARGATE"
    default = "FARGATE"
}

variable "network_mode" {
    type = string
    description = "network_mode none/bridge/awsvpc/host"
    default = "awsvpc"
}



#ECS service





  