locals {
  user       = "qvos"
  tp         = basename(abspath(path.root))
  name       = "${local.user}-${local.tp}"
  tags       = {
    Name  = local.name
    Owner = local.user
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


data "external" "cloud9_ip" {
  program = ["bash", "${path.module}/scripts/get_ip_cloud9.sh"]
}

locals {
  cloud9_ip = data.external.cloud9_ip.result.cloud9_ip
}

