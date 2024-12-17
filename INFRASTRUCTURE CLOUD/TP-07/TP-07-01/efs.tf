# Système de fichiers EFS chiffré
resource "aws_efs_file_system" "nextcloud_efs" {
  encrypted = true
  tags = {
    Name = "${local.name}-efs"
  }
}

# Points de montage dans chaque AZ, avec le groupe de sécurité efs_sg
resource "aws_efs_mount_target" "nextcloud_mount_a" {
  file_system_id  = aws_efs_file_system.nextcloud_efs.id
  subnet_id       = aws_subnet.private[0].id
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_efs_mount_target" "nextcloud_mount_b" {
  file_system_id  = aws_efs_file_system.nextcloud_efs.id
  subnet_id       = aws_subnet.private[1].id
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_efs_mount_target" "nextcloud_mount_c" {
  file_system_id  = aws_efs_file_system.nextcloud_efs.id
  subnet_id       = aws_subnet.private[2].id
  security_groups = [aws_security_group.efs_sg.id]
}
