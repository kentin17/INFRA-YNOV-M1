data "aws_route53_zone" "training" {
  name = "training.akiros.it"
}

resource "aws_route53_record" "nextcloud" {
  zone_id = data.aws_route53_zone.training.zone_id
  name    = "nextcloud-${local.user}"
  type    = "A"
  alias {
    name                   = aws_lb.nextcloud_alb.dns_name
    zone_id                = aws_lb.nextcloud_alb.zone_id
    evaluate_target_health = true
  }
}

