# Outputs
################################
#VPC Outputs
################################
output "vpc-id" {
  value = aws_vpc.two-tier-vpc.id
}

output "pub-sub1-id" {
  value = aws_subnet.pub-sub1.id
}

output "pub-sub2-id" {
  value = aws_subnet.pub-sub2.id
}

output "priv-sub1-id" {
  value = aws_subnet.priv-sub1.id
}

output "priv-sub2-id" {
  value = aws_subnet.priv-sub2.id
}

output "priv-sub2-id" {
  value = aws_subnet.priv-sub2.id
}

output "priv-sub2-id" {
  value = aws_subnet.priv-sub2.id
}

################################
#Gateway Outputs
################################
output "two-tier-igw" {
  value = aws_internet_gateway.two-tier-igw.id
}

output "alb-dns" {
  value = aws_lb.pub-sub-alb.dns_name
}

################################
#Route Table Outputs
################################
output "pub-rt" {
  value = aws_route_table.pub-rt.id
}

output "priv-rt" {
  value = aws_route_table.priv-rt.id
}

################################
#Security Group Outputs
################################
output "alb-sg" {
  value = aws_security_group.alb-sg.id
}

output "asg-sg" {
  value = aws_security_group.asg-sg.id
}

output "db-sg" {
  value = aws_security_group.db-sg.id
}
