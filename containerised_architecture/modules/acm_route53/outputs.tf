output "cert-arn" {
  value       = aws_acm_certificate_validation.test_certificate.certificate_arn
  description = "The ARN of the generated ACM certificate"
}