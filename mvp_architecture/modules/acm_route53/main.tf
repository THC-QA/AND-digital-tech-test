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
resource "aws_route53_zone" "test_zone" {
  name         = "${var.domain_name}"
}
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.test_zone.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.balancer_dns_name
    zone_id                = var.balancer_id
    evaluate_target_health = true
  }
}
resource "aws_acm_certificate_validation" "test_cert_val" {
  certificate_arn         = aws_acm_certificate.test_certificate.arn
}