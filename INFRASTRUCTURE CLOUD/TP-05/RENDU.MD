
Voici la procédure pour réaliser l'exercice :

1. Initialiser le projet Terraform
Créer un répertoire et y entrer :

bash

mkdir TP-05
cd TP-05
Initialiser Terraform :

bash

terraform init
2. Configurer Terraform
Créer les fichiers suivants dans le répertoire :

providers.tf
hcl

provider "aws" {
  region = "eu-west-3"
}
locals.tf
hcl

locals {
  user = "qvos"
  tp   = basename(abspath(path.root))
  name = "${local.user}-${local.tp}"
  tags = {
    Name  = local.name
    Owner = local.user
  }
}
vpc.tf
hcl

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = local.tags
}
subnets.tf
hcl

resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-3a"
  map_public_ip_on_launch = true
  tags              = local.tags
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-3b"
  map_public_ip_on_launch = true
  tags              = local.tags
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-3c"
  map_public_ip_on_launch = true
  tags              = local.tags
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-west-3a"
  tags              = local.tags
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "eu-west-3b"
  tags              = local.tags
}

resource "aws_subnet" "private_subnet_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "eu-west-3c"
  tags              = local.tags
}
route_tables.tf
hcl

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = local.tags
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = local.tags
}

resource "aws_route_table_association" "public_subnet_a_association" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_subnet_a_association" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_rt.id
}
internet_gateway.tf
hcl

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
security_groups.tf
hcl

resource "aws_security_group" "bastion_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR_PUBLIC_IP/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = local.tags
}
instances.tf
hcl

resource "aws_instance" "bastion" {
  ami           = "ami-08eb150f611ca277f"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet_a.id
  tags          = local.tags
}

resource "aws_instance" "nextcloud" {
  ami           = "ami-08eb150f611ca277f"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private_subnet_a.id
  tags          = local.tags
}
efs.tf
hcl

resource "aws_efs_file_system" "nextcloud" {
  encrypted = true
  tags = merge(local.tags, { Name = "nextcloud-efs" })
}

resource "aws_efs_mount_target" "efs_mount_targets" {
  count          = 3
  file_system_id = aws_efs_file_system.nextcloud.id
  subnet_id      = element([
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id,
    aws_subnet.private_subnet_c.id
  ], count.index)
  security_groups = [aws_security_group.bastion_sg.id]
}
3. Appliquer le projet
bash

terraform apply
4. Mettre à jour le fichier SSH
Créer un script update_ssh_config.sh :

bash

#!/bin/bash
echo "Host bastion
  HostName $(terraform output bastion_public_ip)
  User ec2-user
  IdentityFile ~/.ssh/bastion

Host nextcloud
  HostName $(terraform output nextcloud_private_ip)
  ProxyJump bastion
  User ec2-user
  IdentityFile ~/.ssh/nextcloud" > ~/.ssh/config
chmod 600 ~/.ssh/config
Exécuter le script :

bash

bash update_ssh_config.sh
5. Tester la connexion
bash

ssh bastion
ssh nextcloud





