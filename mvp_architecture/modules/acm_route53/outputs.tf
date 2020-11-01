output "cert_arn" {
  value       = aws_acm_certificate.test_certificate.arn
  description = "The ARN of the generated ACM certificate"
}
# output "route53_zone_id" {
#     value       = aws_route53_zone.test_zone.zone_id
#     description = "The zone id for the route53 zone, used for the elb/route53 record"
# }