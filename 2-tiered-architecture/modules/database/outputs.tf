################################
# Outputs
################################

#Db Subnet Group
################################
output "db-subnet-group_id" {
  value = aws_autoscaling_group.db_subnet.id
}

output "db-subnet-group_arn" {
  value = aws_autoscaling_group.db_subnet.arn
}

#DB Instance
################################
output "db-instance_id" {
  value = aws_db_instance.db_instance.id
}

output "db-instance_name" {
  value = aws_db_instance.db_instance.db_name
}
