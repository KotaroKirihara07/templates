# Amazon Elastic Compute Cloud (Amazon Linux 2023)
resource "aws_instance" "ec2instance" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.instance_type
  private_ip                  = var.private_ip
  subnet_id                   = var.public_subnet.id
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