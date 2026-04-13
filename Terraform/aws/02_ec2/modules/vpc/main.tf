# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.prefix}_vpc"
  }
}


# public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr_block
  tags = {
    Name = "${var.prefix}_public_subnet"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.prefix}_internet_gateway"
  }
}


# public subnet route table
resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.prefix}_public_subnet_route_table"
  }
}


# public route table association
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet_route_table.id
}


# security group
resource "aws_security_group" "sg_ec2" {
  name        = "${var.prefix}_sg_ec2"
  description = "Allow all outbound traffic"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name = "${var.prefix}_sg_ec2"
  }
}


# Egress rule
resource "aws_vpc_security_group_egress_rule" "egress_rule" {
  security_group_id = aws_security_group.sg_ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
  tags = {
    Name = "${var.prefix}_egress_rule"
  }
}