# Create an autoscaling group with the specified configurations
resource "aws_autoscaling_group" "asg" {
  name                = var.asg-name
  min_size            = var.asg-min
  max_size            = var.asg-max
  desired_capacity    = var.asg-des-cap
  vpc_zone_identifier = [var.pub-sub1-id, var.pub-sub2-id]
  launch_template {
    id = aws_launch_template.lt-asg.id
  }

  # Tag the autoscaling group for easier identification
  tag {
    key                 = "Name"
    value               = var.asg-tag-name
    propagate_at_launch = true
  }
}

# Create a launch template with the specified configurations
resource "aws_launch_template" "lt-asg" {
  name                   = var.lt-asg-name
  image_id               = var.lt-asg-ami
  instance_type          = var.lt-asg-instance_type
  key_name               = var.lt-asg-key
  vpc_security_group_ids = [aws_security_group.lt-sg.id]
  user_data              = filebase64("${path.root}/../../${var.script-name}")
}

# Attach the autoscaling group to the target group of the ALB
resource "aws_autoscaling_attachment" "asg-tg-attach" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_lb_target_group.alb-tg.arn
}
