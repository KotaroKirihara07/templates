

module "vpc" {
  source = "./modules/vpc"

  prefix = var.prefix
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidr_block= var.public_subnet_cidr_block
}


module "ec2" {
  source = "./modules/ec2"

  prefix = var.prefix
  instance_type = var.instance_type
  private_ip = var.private_ip
  public_subnet_id = module.vpc.public_subnet_id
  volume_size = var.volume_size
  volume_type = var.volume_type
  iops = var.iops
  throughput = var.throughput
}