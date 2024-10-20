output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "main_subnet" {
  value = aws_subnet.main_subnet.id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.main_igw.id
}

output "cidr_block" {
  value = aws_subnet.main_subnet.cidr_block
}