# Create an autoscaling group with the specified configurations
resource "aws_autoscaling_group" "asg" {
  name                = var.asg_name
  min_size            = var.asg_min
  max_size            = var.asg_max
  desired_capacity    = var.asg_des_cap
  vpc_zone_identifier = [var.pub_sub1_id, var.pub_sub2_id]
  launch_template {
    id = aws_launch_template.lt_asg.id
  }

  # Tag the autoscaling group for easier identification
  tag {
    key                 = "Name"
    value               = var.asg_tag_name
    propagate_at_launch = true
  }
}

# Create a launch template with the specified configurations
resource "aws_launch_template" "lt_asg" {
  name                   = var.lt_asg_name
  image_id               = var.lt_asg_ami
  instance_type          = var.lt_asg_instance_type
  key_name               = var.lt_asg_key
  vpc_security_group_ids = [var.asg_sg_id]
  user_data              = filebase64("${path.root}/install-apache.sh")
}

# Attach the autoscaling group to the target group of the ALB
resource "aws_autoscaling_attachment" "asg_tg_attach" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = var.alb_tg_arn
}
