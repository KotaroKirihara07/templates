#Amazon Elastic Compute Cloud
resource "aws_instance" "ec2instance" {
  ami = "ami-01205c30badb279ec"  #Amazon Linux 2023
  instance_type = var.instance_type
  private_ip = var.private_ip
  subnet_id = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.sg_ec2.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_excute_role.name
  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
    iops = var.iops
    throughput = var.throughput
    delete_on_termination = true
  }
  tags = {
    Name = "${var.prefix}_ec2instance"
  }
}


#security_group
resource "aws_security_group" "sg_ec2" {
  name        = "${var.prefix}_sg_ec2"
  description = "Allow all outbound traffic"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name = "${var.prefix}_sg_ec2"
  }
}


#egress rule
resource "aws_vpc_security_group_egress_rule" "egress_rule" {
  security_group_id = aws_security_group.sg_ec2.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
  tags = {
    Name = "${var.prefix}_egress_rule"
  }
}


#Amazon Elastic Compute Cloud実行ロール
resource "aws_iam_instance_profile" "ec2_excute_role" {
  name = "ec2_excute_role"
  role = "AmazonSSMManagedInstanceCore"
}


#Ubuntuイメージ
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}


#Amazon Linux 2023イメージ
data "aws_ami" "amazonlinux2023" {
  aaa
}