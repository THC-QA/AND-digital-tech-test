 output "cert_arn" {
  value       = aws_acm_certificate_validation.test_cert_val.certificate_arn
  description = "The ARN of the generated ACM certificate"
}