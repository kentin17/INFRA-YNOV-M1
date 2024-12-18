# Création du Launch Template pour Nextcloud
resource "aws_launch_template" "nextcloud_lt" {
  name_prefix   = "${local.name}-nextcloud-lt-"
  image_id      = data.aws_ami.nextcloud_ami.id  # ID de l'AMI récupérée dynamiquement
  instance_type = "t3.micro"                # Type d'instance identique à l'instance Nextcloud
  key_name      = aws_key_pair.nextcloud.key_name
  vpc_security_group_ids = [aws_security_group.nextcloud_sg.id]

  # Désactiver le user_data car il ne sert plus
  disable_api_termination = false
  update_default_version  = true

  # Configuration des tags pour le template
  tag_specifications {
    resource_type = "instance"
    tags = merge(local.tags, {
      Name = "${local.name}-nextcloud-instance"
    })
  }

  tag_specifications {
    resource_type = "volume"
    tags = merge(local.tags, {
      Name = "${local.name}-nextcloud-volume"
    })
  }

  tag_specifications {
    resource_type = "network-interface"
    tags = merge(local.tags, {
      Name = "${local.name}-nextcloud-network-interface"
    })
  }

  # Tags pour le Launch Template lui-même
  tags = merge(local.tags, {
    Name = "${local.name}-launch-template"
  })
}

