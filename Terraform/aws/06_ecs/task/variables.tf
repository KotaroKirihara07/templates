# ----------------------------
# prefix
# ----------------------------

variable "prefix" {
    type = string
    description = "prefix"
    default = "test"
}


# ----------------------------
# VPC 
# ----------------------------

variable "vpc_cidr_block" {
    type = string
    description = "vpc cidr block"
    default = "192.168.0.0/16"
}

variable "public_subnet_cidr_block" {
    type = string
    description = "public subnet cidr block"
    default = "192.168.10.0/24"
}


# ----------------------------
# CloudWatch
# ----------------------------

variable "log_group_name" {
    type = string
    description = "log group name"
    default = "esc_task_log_group"
}

variable "retention_in_days" {
    type = int
    description = "retention in days"
    default = 365
}
