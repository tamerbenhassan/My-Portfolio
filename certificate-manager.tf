/* 
Create Certificates ----> Validate Certificate (by adding CNAMEs records for 
the domain + the subject alternative domain to route 53) --->
*/

resource "aws_acm_certificate" "cert" {
  domain_name               = "tamerbenhassan.com"
  subject_alternative_names = ["www.tamerbenhassan.com"]

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "website_hz" {
  name         = "tamerbenhassan.com"
  private_zone = false
}

resource "aws_route53_record" "website_record" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
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
  zone_id         = data.aws_route53_zone.website_hz.zone_id
}

resource "aws_acm_certificate_validation" "website_cert_valid" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.website_record : record.fqdn]
}

output "certif_arn" {
  value = aws_acm_certificate.cert.arn
}
