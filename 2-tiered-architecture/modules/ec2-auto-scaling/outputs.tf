# Outputs
################################
output "asg_name" {
  value = aws_autoscaling_group.asg.name
}

output "asg_id" {
  value = aws_autoscaling_group.asg.id
}

output "asg_arn" {
  value = aws_autoscaling_group.asg.arn
}