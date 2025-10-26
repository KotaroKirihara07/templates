#Amazon Elastic Compute Cloud
variable "instance_type" {
  type = string
  description = "EC2 instance type"
  default = "t3.micro"
}

variable "private_ip" {
  type = string
  description = "private IP address"
  default = "192.168.10.10"
}

#EBS
variable "volume_size" {
    type = number
    description = "EBS volume_size (GB)"
    default = 8
}

variable "volume_type" {
    type = string
    description = "EBS volume_type"
    default = "gp3"
}

variable "iops" {
    type = number
    description = "EBS iops"
    default = 3000
}

variable "throughput" {
    type = number
    description = "EBS throughput"
    default = 125
}