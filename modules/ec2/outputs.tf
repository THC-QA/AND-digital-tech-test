output "public_ip" {
  value       = aws_instance.jenkins.public_ip
  description = "The public IP of the Jenkins server"
}
output "jenkins-id" {
  description = "The instance id for Jenkins server"
  value       = aws_instance.jenkins.id
}