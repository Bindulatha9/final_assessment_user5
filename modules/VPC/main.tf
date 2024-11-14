resource "aws_vpc" "user5vpc" {
    cidr_block = var.cidr
    tags = {
        Name = "user5vpc"
    }  
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.user5vpc.id
  cidr_block              = var.sub1
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "user5subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.user5vpc.id
  cidr_block              = var.sub2
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "user5subnet2"
  }
}

resource "aws_internet_gateway" "user5-ig" {
  vpc_id = aws_vpc.user5vpc.id
  tags = {
    "Name" = "user5-igateway"
  }
}


resource "aws_route_table" "user5rt" {
  vpc_id = aws_vpc.user5vpc.id
}


resource "aws_route" "user5route" {
  route_table_id         = aws_route_table.user5rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.user5-ig.id
}


resource "aws_route_table_association" "user5-rt-assoc" {
  route_table_id = aws_route_table.user5rt.id
  subnet_id      = aws_subnet.subnet1.id
}
