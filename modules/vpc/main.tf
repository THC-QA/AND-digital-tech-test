resource "aws_vpc" "vpc-module-test" {
  cidr_block           =  var.vpc-cidr-block
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-module-test"
  }
}
data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_subnet" "public-block1" {
  cidr_block        = var.pub-sub-block1
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id            = aws_vpc.vpc-module-test.id
  map_public_ip_on_launch = true
  tags = {
        "kubernetes.io/cluster/nginx" = "shared"  #kubernetes.io/cluster/<name_of_cluster>
        "kubernetes.io/role/elb" = "1"
      }     
}
resource "aws_subnet" "public-block2" {
  cidr_block        = var.pub-sub-block2
  availability_zone = data.aws_availability_zones.available.names[1]
  vpc_id            = aws_vpc.vpc-module-test.id
  map_public_ip_on_launch = true
  tags = {
        "kubernetes.io/cluster/nginx" = "shared"
        "kubernetes.io/role/elb" = "1"
      } 
}
resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.vpc-module-test.id
  tags = {
    Name = "VPC Internet Gateway"
  }
}
resource "aws_route_table" "vpc-rt" {
  vpc_id = aws_vpc.vpc-module-test.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-igw.id
  }
  tags = {
    Name = "Route Table for VPC"
  }
}
resource "aws_route_table_association" "pub-sub-rta" {
  subnet_id      = aws_subnet.public-block1.id
  route_table_id = aws_route_table.vpc-rt.id
}
resource "aws_route_table_association" "pub-sub-rtb" {
  subnet_id      = aws_subnet.public-block2.id
  route_table_id = aws_route_table.vpc-rt.id
}