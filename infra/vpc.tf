resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "healthpay-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr

  tags = {
    Name = "healthpay-public-subnet"
  }
}
