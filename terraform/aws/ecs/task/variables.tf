#ECS cluster



#ECS cluster capacity providers



#container definitions
variable "container_definitions" {
    type = string
    description = "container definitions"
}

variable "requires_compatibilities" {
    type = string
    description = "----"
    default = "FARGATE"
    # { "EC2" | "FARGATE" }
}

variable "network_mode" {
    type = string
    description = "network_mode none/bridge/awsvpc/host"
    default = "awsvpc"
    # { "awsvpc" |}
}  