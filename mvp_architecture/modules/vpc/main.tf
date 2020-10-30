resource "aws_vpc" "test_vpc" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
  tags = {
    Name = "test_vpc"
  }
}
data "aws_availability_zones" "available" {
    state = "available"
}
resource "aws_subnet" "public_block_1" {
    cidr_block = var.pub_sub_block_1
    availability_zone = data.aws_availability_zones.available.names[0]
    vpc_id = aws_vpc.test_vpc.id
    map_public_ip_on_launch = true
} 
resource "aws_subnet" "public_block_2" {
    cidr_block = var.pub_sub_block_2
    availability_zone = data.aws_availability_zones.available.names[1]
    vpc_id = aws_vpc.test_vpc.id
    map_public_ip_on_launch = true
} 
resource "aws_internet_gateway" "vpc_igw" {
    vpc_id = aws_vpc.test_vpc.id
    tags = {
        Name = "VPC Internet Gateway"
    }
}
resource "aws_route_table" "vpc_rt" {
    vpc_id = aws_vpc.test_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.vpc_igw.id
    }
}
resource "aws_route_table_association" "sub1" {
  subnet_id      = aws_subnet.public_block_1.id
  route_table_id = aws_route_table.vpc_rt.id
}
resource "aws_route_table_association" "sub2" {
  subnet_id      = aws_subnet.public_block_2.id
  route_table_id = aws_route_table.vpc_rt.id
}