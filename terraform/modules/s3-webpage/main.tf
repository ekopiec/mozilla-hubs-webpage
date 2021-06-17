#Create S3 bucket to be used as a webpage
resource "aws_s3_bucket" "webpage_bucket" {
  bucket = "${var.subdomain}.${var.domain}"
  acl = "public-read"
  website {
    index_document = var.webpage_index
  }
}

#Create S3 bucket policy for access to bucket objects
resource "aws_s3_bucket_policy" "pub_ro" {
  bucket = aws_s3_bucket.webpage_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "PublicReadGetObject"
        Effect = "Allow"
        "Principal": {
          "AWS": aws_cloudfront_origin_access_identity.cf_identity.iam_arn
        }
        Action = "s3:GetObject"
        Resource = [
          aws_s3_bucket.webpage_bucket.arn,
          "${aws_s3_bucket.webpage_bucket.arn}/*",
        ]
      },
    ]
  })
}

#Create S3 bucket object for webpage index
resource "aws_s3_bucket_object" "index_html" {
  bucket = aws_s3_bucket.webpage_bucket.id
  key = var.webpage_index
  content = var.webpage_index_content
  content_type = "text/html"
}

#Retrieve Route53 zone for second level domain
data "aws_route53_zone" "main" {
  name = var.domain
}

#Create SSL cert
resource "aws_acm_certificate" "ssl_cert" {
  domain_name = "${var.subdomain}.${var.domain}"
  validation_method = "DNS"
}

#Create DNS validation records
resource "aws_route53_record" "dns_cert_validation" {
  for_each = {
    for opt in aws_acm_certificate.ssl_cert.domain_validation_options : opt.domain_name => {
      name = opt.resource_record_name
      record = opt.resource_record_value
      type = opt.resource_record_type
    }
  }

  allow_overwrite = true
  name = each.value.name
  records = [each.value.record]
  ttl = 60
  type = each.value.type
  zone_id = data.aws_route53_zone.main.zone_id
}

#Create CloudFront Origin Access Identity
resource "aws_cloudfront_origin_access_identity" "cf_identity" {
}

#Create CloudFront distribution
resource "aws_cloudfront_distribution" "s3_cdn" {
  enabled = true
  default_root_object = var.webpage_index
  aliases = ["${var.subdomain}.${var.domain}"]
  

  origin {
    domain_name = aws_s3_bucket.webpage_bucket.bucket_domain_name
    origin_id = aws_s3_bucket.webpage_bucket.id #ID will always be a unique value
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cf_identity.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    target_origin_id = aws_s3_bucket.webpage_bucket.id
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    viewer_protocol_policy = "https-only"
    
    forwarded_values {
      cookies {
        forward = "all"
      }
      query_string = false
    }

    min_ttl = 60 #Only allow refresh of cached objects every 60 sec
    default_ttl = 14400 #Refresh content every 4h
    max_ttl = 43200 #Refresh cached objects after 12h, even if other headers such as cache-control are set
  }
  
  viewer_certificate  {
    acm_certificate_arn = aws_acm_certificate.ssl_cert.arn
    ssl_support_method = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

#Create CNAME record
resource "aws_route53_record" "dev-ns" {
  zone_id = data.aws_route53_zone.main.zone_id
  name = "${var.subdomain}.${var.domain}"
  type = "CNAME"
  ttl = "60"
  records = [aws_cloudfront_distribution.s3_cdn.domain_name]
}