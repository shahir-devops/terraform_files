resource "aws_vpc" "flipkart" {
  cidr_block           = "172.16.0.0/24"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "flipkartvpc"
  }
}

resource "aws_subnet" "publicsubnet1a" {
  vpc_id                  = aws_vpc.flipkart.id
  cidr_block              = "172.16.0.0/26"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "flipkart-public-subnet-1a"
  }
}

resource "aws_subnet" "privatesubnet1a" {
  vpc_id            = aws_vpc.flipkart.id
  cidr_block        = "172.16.0.64/26"
  availability_zone = "ap-south-1a"

  tags = {
    "Name" = "flipkart-private-subnet-1a"
  }
}

resource "aws_subnet" "publicsubnet1b" {
  vpc_id                  = aws_vpc.flipkart.id
  cidr_block              = "172.16.0.128/26"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "flipkart-public-subnet-1b"
  }
}

resource "aws_subnet" "privatesubnet1b" {
  vpc_id            = aws_vpc.flipkart.id
  cidr_block        = "172.16.0.192/26"
  availability_zone = "ap-south-1b"

  tags = {
    "Name" = "flipkart-private-subnet-1b"
  }
}

resource "aws_internet_gateway" "awsigw" {
  vpc_id = aws_vpc.flipkart.id

  tags = {
    "Name" = "demovpcigw"
  }
}

resource "aws_route_table" "flipkartroute1a" {
  vpc_id = aws_vpc.flipkart.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.awsigw.id
  }

  tags = {
    Name = "awsroutetable"
  }
}

resource "aws_route_table" "flipkartroute1b" {
  vpc_id = aws_vpc.flipkart.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.awsigw.id
  }
  tags = {
    Name = "awsroute1b"
  }
}

resource "aws_route_table_association" "awsrouteass1a" {
  subnet_id      = aws_subnet.publicsubnet1a.id
  route_table_id = aws_route_table.flipkartroute1a.id
}
resource "aws_route_table_association" "awsrouteass1b" {
  subnet_id      = aws_subnet.publicsubnet1b.id
  route_table_id = aws_route_table.flipkartroute1b.id
}

resource "aws_eip" "eip1a" {
  domain = "vpc"

  tags = {
    "Name" = "ElasticIp"
  }
}
resource "aws_eip" "eip2a" {
  domain = "vpc"

  tags = {
    "Name" = "ElasticIp"
  }
}
resource "aws_nat_gateway" "flipkartnat" {
  allocation_id = aws_eip.eip1a.id
  subnet_id     = aws_subnet.publicsubnet1a.id

  tags = {
    Name = "gw NAT a1"
  }

  depends_on = [aws_internet_gateway.awsigw]
}
resource "aws_nat_gateway" "flipkartnat1b" {
  allocation_id = aws_eip.eip2a.id
  subnet_id     = aws_subnet.publicsubnet1b.id

  tags = {
    Name = "gw NAT 1b"
  }
  depends_on = [aws_internet_gateway.awsigw]
}
resource "aws_route_table" "rt1a" {
  vpc_id = aws_vpc.flipkart.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.flipkartnat.id
  }
  tags = {
    "Name" = "rt1a"
  }
}
resource "aws_route_table" "rt1b" {
  vpc_id = aws_vpc.flipkart.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.flipkartnat1b.id
  }
  tags = {
    "Name" = "rt1b"
  }
}

resource "aws_route_table_association" "rta1apr" {
  subnet_id = aws_subnet.privatesubnet1a.id
  route_table_id = aws_route_table.rt1a.id
}

resource "aws_route_table_association" "rta1bpr" {
  subnet_id = aws_subnet.privatesubnet1b.id
  route_table_id = aws_route_table.rt1b.id
}

