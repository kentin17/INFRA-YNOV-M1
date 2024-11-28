resource "aws_key_pair" "bastion" {
  key_name   = "${local.name}-bastion"
  public_key = file("~/.ssh/bastion.pub")
  tags = local.tags
}

resource "aws_key_pair" "nextcloud" {
  key_name   = "${local.name}-nextcloud"
  public_key = file("~/.ssh/nextcloud.pub")
  tags = local.tags
}

resource "aws_instance" "bastion" {
  ami           = "ami-08eb150f611ca277f"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet_a.id
  key_name      = aws_key_pair.bastion.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  tags          = local.tags
}

resource "aws_instance" "nextcloud" {
  ami           = "ami-08eb150f611ca277f"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private_subnet_a.id
  key_name      = aws_key_pair.nextcloud.key_name
  vpc_security_group_ids = [aws_security_group.nextcloud_sg.id]
  user_data = <<-EOF
#!/bin/bash
sudo apt update -y
sudo apt install -y nfs-common mysql-client-core-8.0
mkdir -p /mnt/efs
sudo mount -t nfs ${aws_efs_file_system.nextcloud.dns_name}:/ /mnt/efs

# Variables de connexion à RDS
DB_HOST=$(echo "${aws_db_instance.nextcloud_rds.endpoint}" | sed 's/:3306//')
DB_USER="admin"
DB_PASS="password123"

# Initialisation de la base de données
mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -e "CREATE DATABASE IF NOT EXISTS testdb;"
mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -e "USE testdb;
CREATE TABLE IF NOT EXISTS users (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(50));
INSERT INTO users (name) VALUES ('John Doe'), ('Jane Doe');
"
EOF
  tags = local.tags
}

resource "null_resource" "save_outputs" {
  provisioner "local-exec" {
    command = "terraform output -json > ~/.ssh/terraform_outputs.json"
  }

  depends_on = [
    aws_instance.bastion,
    aws_instance.nextcloud
  ]
}
