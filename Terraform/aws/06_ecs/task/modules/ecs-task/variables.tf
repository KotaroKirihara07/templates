# ----------------------------
# prefix
# ----------------------------

variable "prefix" {
    type = string
    description = "prefix"
    default = "test"
}


# ----------------------------
# commons
# ----------------------------

variable "account_id" {
    type = string
    description = "account id"
    default = "123456789012"
}

variable "region" {
    type = string
    description = "region"
    default = "ap-northeast-1"
}


# ----------------------------
# ECS task
# ----------------------------

variable "task_definition_name" {
    type = string
    description = "task definition name"
    default = "hello-world"
}

variable "image_name" {
    type = string
    description = "image name"
    default = "public.ecr.aws/docker/library/hello-world:latest"
}


# ----------------------------
# CloudWatch
# ----------------------------

variable "log_group_name" {
    type = string
    description = "log group name"
    default = "esc_task_log_group"
}