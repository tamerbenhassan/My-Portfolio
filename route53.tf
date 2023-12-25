resource "aws_route53_zone" "website_hz" {
  name = "tamerbenhassan.com"

}

// A type records for Cloudront distribution name

resource "aws_route53_record" "empty" {
  zone_id = aws_route53_zone.website_hz.zone_id
  name    = "tamerbenhassan.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.website_hz.zone_id
  name    = "www.tamerbenhassan.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}
