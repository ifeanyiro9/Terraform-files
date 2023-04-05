# Create a new load balancer
resource "aws_lb" "pub-sub-alb" {
  name            = "pub-sub-alb"
  subnets         = [aws_subnet.pub-sub1.id, aws_subnet.pub-sub2.id]
  security_groups = [aws_security_group.alb-sg.id]

  tags = {
    Name = "Pub-Sub-ALB"
  }
}

resource "aws_lb_target_group" "alb-tg" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terraform-vpc.id

  health_check {
    interval = 60
    path     = "/var/www/html/index.html"
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
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }
}
