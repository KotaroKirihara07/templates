variable "prefix" {
    type = string
    description = "prefix "
    default = "test"
}

#vpc
variable "vpc_cidr_block" {
    type = string
    description = "vpc cidr block "
    default = "192.168.0.0/16"
}

#public subnet
variable "public_subnet_cidr_block" {
    type = string
    description = "public subnet cidr block "
    default = "192.168.10.0/24"
}

#private subnet
variable "private_subnet_cidr_block" {
    type = string
    description = "private subnet cidr block "
    default = "192.168.20.0/24"
}