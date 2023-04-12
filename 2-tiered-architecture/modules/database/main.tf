# Database subnet group
resource "aws_db_subnet_group" "db_subnet" {
  name       = var.db-sub-name
  subnet_ids = [var-pub-sub1-id, var.pub-sub2-id]
}


# Database instance in Private Subnet 1
resource "aws_db_instance" "db_instance" {
  allocated_storage           = var.allocated-storage #5
  storage_type                = var.storage-type #"gp2"
  engine                      = var.engine #"mysql"
  engine_version              = var.engine-version #"5.7"
  instance_class              = var.instance-class #"db.t2.micro"
  db_subnet_group_name        = var.db-sub-name
  vpc_security_group_ids      = var.vpc-security-group-ids #[aws_security_group.db_sg.id]
  parameter_group_name        = var.parameter-group-name #"default.mysql5.7"
  db_name                     = var.db-name#"two-tier-db"
  username                    = var.db-name #"admin"
  password                    = var.password #"password"
  allow_major_version_upgrade = var.allow-major-version-upgrade #true
  auto_minor_version_upgrade  = var.auto-minor-version-upgrade #true
  backup_retention_period     = var.backup-retention-period #35
  backup_window               = var.backup-window #"22:00-23:00"
  maintenance_window          = var.maintenance-window #"Sat:00:00-Sat:03:00"
  multi_az                    = var.multi-az #false
  skip_final_snapshot         = var.skip-final-snapshot #true
}