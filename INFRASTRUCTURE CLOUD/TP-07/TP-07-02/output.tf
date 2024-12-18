output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = aws_db_instance.nextcloud_rds.endpoint
}

output "rds_password" {
  value       = random_password.rds_password.result
  description = "The RDS database password"
  sensitive   = true
}

output "nextcloud_fqdn" {
  description = "FQDN de l'application Nextcloud"
  value       = aws_route53_record.nextcloud.name
}
output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}
output "bastion_private_ip" {
  value = aws_instance.bastion.private_ip
}

output "nextcloud_private_ip" {
  value = aws_instance.nextcloud.private_ip
}

output "cloud9_ip" {
  description = "Public IP address of the Cloud9 instance with Owner = qvos"
  value       = local.cloud9_ip
}

output "nextcloud_rds_endpoint" {
  value = aws_db_instance.nextcloud_rds.endpoint
}