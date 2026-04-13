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