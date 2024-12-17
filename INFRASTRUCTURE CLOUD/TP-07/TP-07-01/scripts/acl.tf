resource "aws_network_acl" "public_acl" {
  vpc_id = aws_vpc.main.id
  tags   = merge(local.tags, { Name = "${local.name}-public-acl" })

  ingress {
    rule_no    = 100
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "${local.cloud9_ip}/32"
    from_port  = 22
    to_port    = 22
  }

  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}

resource "aws_network_acl" "private_acl" {
  vpc_id = aws_vpc.main.id
  tags   = merge(local.tags, { Name = "${local.name}-private-acl" })

  ingress {
    rule_no    = 110
    protocol   = "tcp"
    action     = "allow"
    cidr_block = aws_subnet.private_subnet_a.cidr_block
    from_port  = 3306
    to_port    = 3306
  }

  ingress {
    rule_no    = 120
    protocol   = "tcp"
    action     = "allow"
    cidr_block = aws_subnet.private_subnet_b.cidr_block
    from_port  = 3306
    to_port    = 3306
  }

  ingress {
    rule_no    = 130
    protocol   = "tcp"
    action     = "allow"
    cidr_block = aws_subnet.private_subnet_c.cidr_block
    from_port  = 3306
    to_port    = 3306
  }
  ingress {
    rule_no    = 100
    protocol   = "tcp"
    action     = "allow"
    cidr_block = "${aws_instance.bastion.private_ip}/32"
    from_port  = 22
    to_port    = 22
  }
  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}

resource "aws_network_acl_association" "public_acl_a" {
  network_acl_id = aws_network_acl.public_acl.id
  subnet_id      = aws_subnet.public_subnet_a.id
}

resource "aws_network_acl_association" "public_acl_b" {
  network_acl_id = aws_network_acl.public_acl.id
  subnet_id      = aws_subnet.public_subnet_b.id
}

resource "aws_network_acl_association" "public_acl_c" {
  network_acl_id = aws_network_acl.public_acl.id
  subnet_id      = aws_subnet.public_subnet_c.id
}

resource "aws_network_acl_association" "private_acl_a" {
  network_acl_id = aws_network_acl.private_acl.id
  subnet_id      = aws_subnet.private_subnet_a.id
}

resource "aws_network_acl_association" "private_acl_b" {
  network_acl_id = aws_network_acl.private_acl.id
  subnet_id      = aws_subnet.private_subnet_b.id
}

resource "aws_network_acl_association" "private_acl_c" {
  network_acl_id = aws_network_acl.private_acl.id
  subnet_id      = aws_subnet.private_subnet_c.id
}

