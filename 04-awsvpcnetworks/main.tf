resource "aws_vpc" "flipkart" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  tags = {
    Name = "flipkart"
  }
}

resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.flipkart.id
  cidr_block = "10.0.0.0/17"
  tags = {
    Name = "flipkart - sub 1a"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.flipkart.id
  tags = {
    Name = "flipkart-igw"
  }
}
resource "aws_route_table" "fliprt" {
  vpc_id = aws_vpc.flipkart.id
  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }
}
resource "aws_route_table_association" "fliprta" {
  route_table_id = aws_route_table.fliprt.id
  subnet_id      = aws_subnet.sub1.id
}

resource "aws_subnet" "sub2private" {
  vpc_id     = aws_vpc.flipkart.id
  cidr_block = "10.0.128.0/17"
  tags = {
    Name = "private-sub2"
  }
}
resource "aws_eip" "awseip" {
  domain = "vpc"
}
resource "aws_nat_gateway" "flipnat" {
  allocation_id = aws_eip.awseip.id
  subnet_id     = aws_subnet.sub1.id

  tags = {
    Name = "flipkart-natgateway"
  }
  depends_on = [aws_internet_gateway.igw]
}
resource "aws_route_table" "private1a" {
  vpc_id = aws_vpc.flipkart.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.flipnat.id
  }
  tags = {
    Name = "awsrtprivate"
  }
}
resource "aws_route_table_association" "privaterta" {
  subnet_id      = aws_subnet.sub2private.id
  route_table_id = aws_route_table.private1a.id
}

resource "aws_security_group" "sec_tls" {
  name        = "allow_tls"
  description = "allow_tls"
  vpc_id      = aws_vpc.flipkart.id

  ingress {
    description = "TLS from ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}