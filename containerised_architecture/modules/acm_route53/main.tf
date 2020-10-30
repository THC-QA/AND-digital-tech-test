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

data "aws_route53_zone" "test_zone" {
  name         = "${var.domain-name}"
  private_zone = false
  vpc {
    vpc_id = "${var.vpc_id}"
  }
}

resource "aws_route53_record" "test_route_record" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
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
  zone_id         = data.aws_route53_zone.test_zone.zone_id
}

resource "aws_acm_certificate_validation" "test_cert_val" {
  certificate_arn         = aws_acm_certificate.test_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.test_route_record : record.fqdn]
}

resource "aws_lb_listener" "test_lb_listener" {
  # need to test if I have money for domain

  certificate_arn = aws_acm_certificate_validation.test_cert_val.certificate_arn
}