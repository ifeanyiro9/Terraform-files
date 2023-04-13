# Create a new load balancer
resource "aws_lb" "pub_sub_alb" {
  name            = var.pub_sub_alb_name
  subnets         = [var.pub_sub1_id, var.pub_sub2_id]
  security_groups = [var.alb_sg_id]

  tags = {
    Name = var.pub_sub_alb_tag
  }
}

# Create a target group for the load balancer
resource "aws_lb_target_group" "alb_tg" {
  name     = var.target_group_name
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id

  # Set the health check configuration for the target group
  health_check {
    interval = var.alb_hc_interval
    path     = var.alb_hc_path
    port     = var.alb_hc_port
    timeout  = var.alb_hc_timeout
    protocol = var.alb_hc_protocol
    matcher  = var.alb_hc_matcher
  }
}

# Create ALB listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.pub_sub_alb.arn
  port              = var.alb_listener_port
  protocol          = var.alb_listener_protocol

  # Set the default action for the listener
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}
