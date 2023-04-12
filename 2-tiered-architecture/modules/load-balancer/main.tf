# Create a new load balancer
resource "aws_lb" "pub-sub-alb" {
  name            = var.load_balancer_name
  subnets         = [var.pub-sub1-id, var.pub-sub2-id]
  security_groups = [var.alb-sg.id]

  tags = {
    Name = var.pub-sub-alb-name
  }
}

# Create a target group for the load balancer
resource "aws_lb_target_group" "alb-tg" {
  name     = var.target-group-name
  port     = var.tg-port
  protocol = var.tg-protocol
  vpc_id   = var.vpc-id

  # Set the health check configuration for the target group
  health_check {
    interval = var.alb-hc-interval
    path     = var.alb-hc-path
    port     = var.alb-hc-port
    timeout  = var.alb-hc-timeout
    protocol = var.alb-hc-protocol
    matcher  = var.alb-hc-matcher
  }
}

# Create ALB listener
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = var.alb-arn
  port              = var.alb-listener-port
  protocol          = var.alb-listener-protocol

  # Set the default action for the listener
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }
}
