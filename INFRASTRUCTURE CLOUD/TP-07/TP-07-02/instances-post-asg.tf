# Importer la clé publique pour le bastion
resource "aws_key_pair" "bastion" {
  key_name   = "${local.user}-bastion-key"
  public_key = file("~/.ssh/bastion")
}

# Importer la clé publique pour Nextcloud
resource "aws_key_pair" "nextcloud" {
  key_name   = "${local.user}-nextcloud-key"
  public_key = file("~/.ssh/nextcloud")
}

# Bastion Instance (Public)
resource "aws_instance" "bastion" {
  ami                    = "ami-089146c5626baa6bf"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public[0].id
  key_name               = aws_key_pair.bastion.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  associate_public_ip_address = true

  tags = { Name = "${local.name}-bastion" }
}

# L'instance Nextcloud est désormais gérée par l'ASG.
# L'ancienne configuration Terraform est supprimée ou commentée.