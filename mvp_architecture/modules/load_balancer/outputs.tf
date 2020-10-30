output "balancer_id" {
    value = aws_elb.test_balancer.id
}
output "balancer_dns" {
    value = aws_elb.test_balancer.dns_name
}
output "balancer_zone_id" {
    value = aws_elb.test_balancer.zone_id
}