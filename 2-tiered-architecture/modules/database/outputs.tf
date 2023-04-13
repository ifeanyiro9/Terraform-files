################################
# Outputs
################################

#DB Subnet Group
################################
output "db_subnet_group_id" {
  value = aws_db_subnet_group.db_subnet.id
}

output "db_subnet_group_arn" {
  value = aws_db_subnet_group.db_subnet.arn
}

#DB Instance
################################
output "db_instance_id" {
  value = aws_db_instance.db_instance.id
}

output "db_instance_name" {
  value = aws_db_instance.db_instance.db_name
}
