# Outputs Load Balancer
################################
output "alb_dns" {
  value = aws_lb.pub_sub_alb.dns_name
}

output "alb_arn" {
  value = aws_lb.pub_sub_alb.arn
}

output "alb_id" {
  value = aws_lb.pub_sub_alb.id
}

output "alb_tg_arn" {
  value = aws_lb_target_group.alb_tg.arn
}

output "alb_tg_id" {
  value = aws_lb_target_group.alb_tg.id
}

