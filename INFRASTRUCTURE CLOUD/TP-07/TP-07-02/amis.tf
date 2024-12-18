# Récupérer l'AMI la plus récente avec les critères spécifiés
data "aws_ami" "nextcloud_ami" {
  most_recent = true

  owners = ["self"] # AMI appartenant au compte AWS actuel

  filter {
    name   = "name"
    values = ["${local.user}-*-nextcloud-*"] # Nom de l'AMI
  }

  filter {
    name   = "state"
    values = ["available"] # Statut disponible
  }
}
