resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = local.tags
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_a.id
  tags          = local.tags
}

resource "aws_eip" "nat" {
  domain = "vpc"
  tags   = local.tags
}
