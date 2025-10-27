#commons
variable "prefix" {
    type = string
    description = "prefix "
    default = "test"
}

#ECS task definition
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