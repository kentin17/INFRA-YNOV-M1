resource "aws_lb" "nextcloud_alb" {
  name               = "${local.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = aws_subnet.public[*].id

  enable_deletion_protection = false

  tags = { Name = "${local.name}-alb" }
}

resource "aws_lb_target_group" "nextcloud_tg" {
  name        = "${local.name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }

  tags = { Name = "${local.name}-tg" }
}

resource "aws_lb_target_group_attachment" "nextcloud_attachment" {
  target_group_arn = aws_lb_target_group.nextcloud_tg.arn
  target_id        = aws_instance.nextcloud.id
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.nextcloud_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nextcloud_tg.arn
  }
}