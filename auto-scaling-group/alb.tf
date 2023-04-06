# Create a new load balancer
resource "aws_lb" "pub-sub-alb" {
  name            = var.load_balancer_name
  subnets         = [aws_subnet.pub-sub1.id, aws_subnet.pub-sub2.id]
  security_groups = [aws_security_group.alb-sg.id]

  tags = {
    Name = "Pub-Sub-ALB"
  }
}

# Create a target group for the load balancer
resource "aws_lb_target_group" "alb-tg" {
  name     = "var.target_group_name"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terraform-vpc.id

  # Set the health check configuration for the target group
  health_check {
    interval = 60
    path     = "/"
    port     = 80
    timeout  = 45
    protocol = "HTTP"
    matcher  = "200,202"
  }
}


# Create ALB listener
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.pub-sub-alb.arn
  port              = "80"
  protocol          = "HTTP"

  # Set the default action for the listener
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }
}
