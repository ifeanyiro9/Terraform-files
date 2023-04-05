resource "aws_autoscaling_group" "asg" {
  name               = "asg"
  min_size           = 2
  max_size           = 5
  desired_capacity   = 2
  availability_zones = var.availability_zones
  launch_template {
    id = aws_launch_template.lt-asg.id
  }

  tag {
    key                 = "Name"
    value               = "Private Sub ASG"
    propagate_at_launch = true
  }
}

resource "aws_launch_template" "lt-asg" {
  name                   = "lt-asg"
  image_id               = "ami-04581fbf744a7d11f"
  instance_type          = "t2.micro"
  key_name               = "levelupkeypair"
  vpc_security_group_ids = [aws_security_group.terraform-sg.id]
  user_data              = filebase64("${path.root}/install-apache.sh")
}

resource "aws_autoscaling_attachment" "asg-tg-attach" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_lb_target_group.alb-tg.arn
}