# ----------------------------
# prefix
# ----------------------------

prefix = "test"


# ----------------------------
# VPC 
# ----------------------------

vpc_cidr_block           = "192.168.0.0/16"
public_subnet_cidr_block = "192.168.10.0/24"


# ----------------------------
# Amazon Elastic Compute Cloud
# ----------------------------

instance_type = "t3.micro"
private_ip    = "192.168.10.10"


# ----------------------------
# EBS 
# ----------------------------

volume_size = 8
volume_type = "gp3"
iops        = 3000
throughput  = 125
