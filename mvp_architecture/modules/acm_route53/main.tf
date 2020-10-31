resource "aws_acm_certificate" "test_certificate" {
  domain_name       = "${var.domain_name}"
  validation_method = "DNS"
  tags = {
    Environment = "test"
  }
  lifecycle {
    create_before_destroy = true
  }
}
data "aws_route53_zone" "test_zone" {
  name         = "${var.domain_name}"
  private_zone = true
  vpc {
    vpc_id = "${var.vpc_id}"
  }
}
resource "aws_acm_certificate_validation" "test_cert_val" {
  certificate_arn         = aws_acm_certificate.test_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.test_route_record : record.fqdn]
}