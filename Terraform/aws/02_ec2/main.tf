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


# Amazon Elastic Compute Cloud (Amazon Linux 2023)
resource "aws_instance" "ec2instance" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.instance_type
  private_ip                  = var.private_ip
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.sg_ec2.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_excute_role.name
  root_block_device {
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    iops                  = var.iops
    throughput            = var.throughput
    delete_on_termination = true
  }
  tags = {
    Name = "${var.prefix}_ec2instance"
  }
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


# Amazon Elastic Compute Cloud 実行ロール
resource "aws_iam_instance_profile" "ec2_excute_role" {
  name = "${var.prefix}_ec2_excute_role"
  role = "AmazonSSMManagedInstanceCore"

  tags = {
    Name = "${var.prefix}_ec2_excute_role"
  }
}


# Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
