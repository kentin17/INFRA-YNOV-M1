resource "aws_efs_file_system" "nextcloud" {
  encrypted = true
  tags = local.tags
}

resource "aws_efs_mount_target" "nextcloud_mount_target_a" {
  file_system_id  = aws_efs_file_system.nextcloud.id
  subnet_id       = aws_subnet.private_subnet_a.id
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_efs_mount_target" "nextcloud_mount_target_b" {
  file_system_id  = aws_efs_file_system.nextcloud.id
  subnet_id       = aws_subnet.private_subnet_b.id
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_efs_mount_target" "nextcloud_mount_target_c" {
  file_system_id  = aws_efs_file_system.nextcloud.id
  subnet_id       = aws_subnet.private_subnet_c.id
  security_groups = [aws_security_group.efs_sg.id]
}