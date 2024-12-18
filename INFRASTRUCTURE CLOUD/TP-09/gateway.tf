# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags   = { Name = "${local.name}-igw" }
}

# Allocation d'une Elastic IP pour la NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc  = true
  tags = { Name = "${local.name}-nat-eip" }
}

# Création de la NAT Gateway dans un sous-réseau public
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id # Utilisez le premier sous-réseau public
  tags          = { Name = "${local.name}-nat-gateway" }
}
