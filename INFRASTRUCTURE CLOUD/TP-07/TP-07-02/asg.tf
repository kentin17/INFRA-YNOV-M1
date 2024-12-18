resource "aws_autoscaling_group" "nextcloud_asg" {
  launch_template = {
    id      = aws_launch_template.nextcloud_lt.id
    version = "$Latest"
  }

  min_size         = 1
  max_size         = 1
  desired_capacity = 1

  vpc_zone_identifier = aws_subnet.private[*].id

  health_check_type         = "ELB"
  target_group_arns         = [aws_lb_target_group.nextcloud_tg.arn]
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "${local.name}-nextcloud-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Owner"
    value               = local.user
    propagate_at_launch = true
  }

  tags = [
    {
      key                 = "Environment"
      value               = "production"
      propagate_at_launch = true
    }
  ]
}
