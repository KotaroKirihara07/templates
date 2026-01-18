#ECS cluster



#ECS cluster capacity providers


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





  