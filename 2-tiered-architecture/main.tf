#Instance Module
module "auto_scaling_group" {
  source               = "./modules/ec2_auto_scaling"
  pub_sub1_id          = module.network_flow.pub_sub1_id
  pub_sub2_id          = module.network_flow.pub_sub2_id
  lt_asg_ami           = "ami-04581fbf744a7d11f"
  lt_asg_instance_type = "t2.micro"
  lt_asg_key           = "levelupkeypair"
  script_name          = "install-apache.sh"
  asg_sg_id            = module.network_flow.asg_sg_id
  alb_tg_arn           = module.load_balancer.alb_tg_arn
}

#Load Balancer Module
module "load_balancer" {
  source                = "./modules/load_balancer"
  pub_sub1_id           = module.network_flow.pub_sub1_id
  pub_sub2_id           = module.network_flow.pub_sub2_id
  alb_sg_id             = module.network_flow.alb_sg_id
  tg_port               = 80
  tg_protocol           = "HTTP"
  vpc_id                = module.network_flow.vpc_id
  alb_hc_interval       = 60
  alb_hc_path           = "/"
  alb_hc_port           = 80
  alb_hc_timeout        = 45
  alb_hc_protocol       = "HTTP"
  alb_hc_matcher        = "200,202"
  alb_listener_port     = "80"
  alb_listener_protocol = "HTTP"
}

#VPC Module
module "network_flow" {
  source         = "./modules/network_flow"
  vpc_cidr       = var.pm_vpc_cidr
  pub_sub1_cidr  = "10.0.1.0/24"
  pub_sub2_cidr  = "10.0.2.0/24"
  priv_sub1_cidr = "10.0.3.0/24"
  priv_sub2_cidr = "10.0.4.0/24"
  map_public_ip  = true
  az_1           = "us-east-1a"
  az_2           = "us-east-1b"
  pub_rt_cidr    = "0.0.0.0/0"
  priv_rt_cidr   = "0.0.0.0/0"
}


#Data Module
module "database" {
  source                      = "./modules/database"
  priv_sub1_id                 = module.network_flow.priv_sub1_id
  priv_sub2_id                 = module.network_flow.priv_sub2_id
  allocated_storage           = 5
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "db.t2.micro"
  vpc_security_group_ids      = module.network_flow.db_sg_id
  parameter_group_name        = "default.mysql5.7"
  username                    = "two_tier_db"
  db_name                     = var.db_username
  password                    = var.db_password
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  backup_retention_period     = 35
  backup_window               = "22:00-23:00"
  maintenance_window          = "Sat:00:00-Sat:03:00"
  multi_az                    = "false"
  skip_final_snapshot         = true
}