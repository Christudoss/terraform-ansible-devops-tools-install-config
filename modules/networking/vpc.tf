resource "aws_vpc" "devops_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "devops_subnet" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "tf-example"
  }
}



