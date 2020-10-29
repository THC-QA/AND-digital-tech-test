output "aws_wsg_id" {
  value = aws_security_group.wsg.id
}
output "aws_jenkins_sg_id" {
  value = aws_security_group.jenkins-security.id
}