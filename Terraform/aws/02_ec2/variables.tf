# ----------------------------
# prefix
# ----------------------------

variable "prefix" {
  type        = string
  description = "prefix"
  default     = "test"
}


# ----------------------------
# VPC 
# ----------------------------

variable "vpc_cidr_block" {
  type        = string
  description = "vpc cidr block"
  default     = "192.168.0.0/16"
}

variable "public_subnet_cidr_block" {
  type        = string
  description = "public subnet cidr block"
  default     = "192.168.10.0/24"
}


# ----------------------------
# Amazon Elastic Compute Cloud
# ----------------------------

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "private_ip" {
  type        = string
  description = "private IP address"
  default     = "192.168.10.10"
}


# ----------------------------
# EBS 
# ----------------------------

variable "volume_size" {
  type        = number
  description = "EBS volume_size (GB)"
  default     = 8
}

variable "volume_type" {
  type        = string
  description = "EBS volume_type"
  default     = "gp3"
}

variable "iops" {
  type        = number
  description = "EBS iops"
  default     = 3000
}

variable "throughput" {
  type        = number
  description = "EBS throughput"
  default     = 125
}
