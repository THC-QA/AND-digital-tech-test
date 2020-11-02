resource "aws_acm_certificate" "test_certificate" {
  domain_name       = "${var.domain-name}"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_zone" "test_zone" {
  name         = "${var.domain-name}"
}

resource "aws_route53_record" "test_route_record" {
  for_each = {
    for dvo in aws_acm_certificate.test_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.test_zone.zone_id
}

resource "aws_acm_certificate_validation" "test_cert_val" {
  certificate_arn         = aws_acm_certificate.test_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.test_route_record : record.fqdn]
}
############ Load Balancer Paradox ############
#
# Record must be manually created as the load balancer
# for EKS is automatically created AFTER pod deployment
#
# resource "aws_route53_record" "balancer" {
#   zone_id = aws_route53_zone.test_zone.zone_id
#   name    = var.domain-name
#   type    = "A"
#   alias {
#     name                   = var.balancer_dns_name
#     zone_id                = var.balancer_id
#     evaluate_target_health = true
#   }
# }