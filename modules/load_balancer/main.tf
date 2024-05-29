resource "aws_lb" "prashansa_aws_alb" {
  name               = "prashansa-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_id]
#   subnets            = [for subnet in aws_subnet.public : subnet.id]
  subnets            = [var.public_subnet_1, var.public_subnet_2]

  enable_deletion_protection = false

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.id
  #   prefix  = "test-lb"
  #   enabled = true
  # }

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "prashansa_aws_alb_target_group" {
  name     = "prashansa-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 4
    interval            = 9
  }

  tags = {
    Name = "prashansa-alb-tg"
    terraform = "true"
    silo = "intern2"
    owner = "prashansa.joshi"
    environment = "dev"
  }
}

resource "aws_lb_listener" "prashansa_aws_lb_listener" {
  load_balancer_arn = aws_lb.prashansa_aws_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prashansa_aws_alb_target_group.arn
  }
}

# resource "aws_lb_target_group_attachment" "prashansa_aws_lb_target_group_attachment_1" {
#   target_group_arn = aws_lb_target_group.prashansa_aws_alb_target_group.arn
# #   target_id        = var.ec2_id_1
#   port             = 80
# }

# resource "aws_lb_target_group_attachment" "prashansa_aws_lb_target_group_attachment_2" {
#   target_group_arn = aws_lb_target_group.prashansa_aws_alb_target_group.arn
#   target_id        = var.ec2_id_2
#   port             = 80
# }