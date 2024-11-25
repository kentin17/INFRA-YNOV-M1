locals {
  user = "qvos"
  tp   = basename(abspath(path.root))
  name = "${local.user}-${local.tp}"
  tags = {
    Name  = "qvos"
    Owner = "qvos"
  }
}

resource "null_resource" "generate_json" {
  provisioner "local-exec" {
    command = <<EOT
      echo '{
        "bastion_public_ip": "${aws_instance.bastion.public_ip}",
        "nextcloud_private_ip": "${aws_instance.nextcloud.private_ip}"
      }' > ${path.module}/terraform_outputs.json
    EOT
  }

  depends_on = [aws_instance.bastion, aws_instance.nextcloud]
}
