output "balancer_id" {
    value = aws_elb.terraform_elb.id
}
output "balancer_dns" {
    value = aws_elb.terraform_elb.dns_name
}