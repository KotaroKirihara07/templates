# prefix
variable "prefix" {
    type = string
    description = "prefix"
    default = "test"
}

# vpc cidr block
variable "vpc_cidr_block" {
    type = string
    description = "vpc cidr block"
    default = "192.168.0.0/16"
}

# public subnet cidr block
variable "public_subnet_cidr_block" {
    type = string
    description = "public subnet cidr block"
    default = "192.168.10.0/24"
}

# private subnet cidr block
variable "private_subnet_cidr_block" {
    type = string
    description = "private subnet cidr block"
    default = "192.168.20.0/24"
}