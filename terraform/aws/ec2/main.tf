#EC2
resource "aws_instance" "ec2instance" {
  ami = data.aws_ami.amazonlinux2023.id
  instance_type = var.instance_type
  private_ip = var.private_ip
  subnet_id = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.sg_ec2.id]
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
  description = "Allow https inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name = "${var.prefix}_sg_ec2"
  }
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