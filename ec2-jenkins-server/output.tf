#Jenkins Server Output
output "instance_public_ip" {
  value = aws_instance.jenkins.public_ip
}