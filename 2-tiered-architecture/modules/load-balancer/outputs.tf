# Outputs
################################
output "alb_dns" {
  value = aws_lb.pub-sub-alb.dns_name
}

output "alb_tg_arn" {
  value = aws_lb_target_group.alb-tg.arn
}

output "alb_id" {
  value = aws_lb.pub-sub-alb.id
}