# Importer la clé publique pour le bastion
resource "aws_key_pair" "bastion" {
  key_name   = "${local.user}-bastion"
  public_key = file("~/.ssh/bastion.pub")
}

# Importer la clé publique pour Nextcloud
resource "aws_key_pair" "nextcloud" {
  key_name   = "${local.user}-nextcloud"
  public_key = file("~/.ssh/nextcloud.pub")
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

# Nextcloud Instance (Private) avec installation et configuration de Nextcloud
resource "aws_instance" "nextcloud" {
  ami                    = "ami-089146c5626baa6bf"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private[1].id
  key_name               = aws_key_pair.nextcloud.key_name
  vpc_security_group_ids = [aws_security_group.nextcloud_sg.id]

  associate_public_ip_address = false

  # Script User Data pour installer Nextcloud et configurer EFS
  user_data = templatefile("user_data.sh", {
    efs_dns = aws_efs_file_system.nextcloud_efs.dns_name,
    db_name = aws_db_instance.nextcloud_rds.db_name,
    db_host = aws_db_instance.nextcloud_rds.address,
    db_user = aws_db_instance.nextcloud_rds.username,
    db_pass = random_password.rds_password.result,
    fqdn    = "nextcloud-${local.user}.training.akiros.it"
  })

  tags = { Name = "${local.name}-nextcloud" }

  # Dépendances explicites
  depends_on = [
    aws_route_table_association.private_association,
    aws_efs_file_system.nextcloud_efs
  ]
}
