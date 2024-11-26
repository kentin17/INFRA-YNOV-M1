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
sudo apt install -y nfs-common
mkdir -p /mnt/efs
sudo mount -t nfs ${aws_efs_file_system.nextcloud.dns_name}:/ /mnt/efs
#sudo apt install -y mysql
sudo apt install -y mysql-client-core-8.0 
EOF
  tags = local.tags
}


resource "null_resource" "save_outputs" {
  provisioner "local-exec" {
    command = "terraform output -json > ~/.ssh/terraform_outputs.json"
  }

  # Dépendances pour s'assurer que les instances et leurs IPs soient disponibles
  depends_on = [
    aws_instance.bastion,
    aws_instance.nextcloud
  ]
}


