output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}
output "bastion_private_ip" {
  value = aws_instance.bastion.private_ip
}

output "nextcloud_private_ip" {
  value = aws_instance.nextcloud.private_ip
}
