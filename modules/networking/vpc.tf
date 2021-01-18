data "aws_availability_zones" "available" {}


resource "aws_vpc" "devops" {
  cidr_block = var.cidr_block

  tags = {
    Name = "devops"
  }
}

resource "aws_subnet" "devops" {
  count = 2

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "172.16.${count.index}.0/24"
  vpc_id            = aws_vpc.devops.id

  tags = {
    Name = "devops"
  }
}

resource "aws_internet_gateway" "devops" {
  vpc_id = aws_vpc.devops.id

  tags = {
    Name = "devops"
  }
}

resource "aws_route_table" "devops" {
  vpc_id = aws_vpc.devops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops.id
  }
}

resource "aws_route_table_association" "devops" {
  count = 2

  subnet_id      = aws_subnet.devops.*.id[count.index]
  route_table_id = aws_route_table.devops.id
}

