# Database subnet group
resource "aws_db_subnet_group" "db_subnet" {
  name       = var.db_sub_name
  subnet_ids = [var.priv_sub1_id, var.priv_sub2_id]
}


# Database instance in Private Subnet 1
resource "aws_db_instance" "db_instance" {
  allocated_storage           = var.allocated_storage
  storage_type                = var.storage_type
  engine                      = var.engine
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  db_subnet_group_name        = var.db_sub_name
  vpc_security_group_ids      = [var.vpc_security_group_ids]
  parameter_group_name        = var.parameter_group_name
  db_name                     = var.db_name
  username                    = var.db_name
  password                    = var.password
  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  backup_retention_period     = var.backup_retention_period
  backup_window               = var.backup_window
  maintenance_window          = var.maintenance_window
  multi_az                    = var.multi_az
  skip_final_snapshot         = var.skip_final_snapshot
  
  depends_on = [aws_db_subnet_group.db_subnet]
}