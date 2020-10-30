output "nginx_sg_id" {
  value = aws_security_group.nginx_sg.id
}
output "balancer_sg_id" {
  value = aws_security_group.balancer_sg.id
}