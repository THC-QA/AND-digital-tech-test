data "aws_route53_zone" "primary" {
  name = "${var.hosted_zone}"
}
resource "aws_route53_record" "subdomain" {
  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name    = "${var.subdomain}.${var.domain}"
  type    = "A"
  alias {
    name                    = "${var.cloudfront_domain_name}"
    zone_id                 = "Z2FDTNDATAQYW2" # CloudFront ZoneID according to Amazon docs
    evaluate_target_health  = false
  }
}