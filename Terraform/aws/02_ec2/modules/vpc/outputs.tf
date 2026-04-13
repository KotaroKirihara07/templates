# VPC ID
output "vpc_id" {
  value = aws_vpc.vpc.id
}


# public subnet ID
output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}
