# main.tf

# Provider block (You may need to replace the AWS provider with the appropriate one for your cloud provider)
provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# Subnets
locals {
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
  private_subnet_cidrs = ["10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24", "10.0.8.0/24"]
}

resource "aws_subnet" "public" {
  count = length(local.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = local.public_subnet_cidrs[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "Public-Subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count = length(local.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = local.private_subnet_cidrs[count.index]
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "Private-Subnet-${count.index + 1}"
  }
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  count = length(local.private_subnet_cidrs)
  subnet_id = aws_subnet.public[count.index].id
  allocation_id = aws_eip.nat[count.index].id
}

resource "aws_eip" "nat" {
  count = length(local.private_subnet_cidrs)
}

# Transit Gateway (Optional: Requires AWS provider version 3.24.0 or higher)
resource "aws_ec2_transit_gateway" "transit_gateway" {
  count = var.create_transit_gateway ? 1 : 0
  tags = {
    Name = var.transit_gateway_name
  }
}
