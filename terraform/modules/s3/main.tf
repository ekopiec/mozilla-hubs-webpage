resource "aws_s3_bucket" "webpage" {
  bucket = var.webpage_domain
  acl = "pub_ro"
  policy = aws_s3_bucket_policy.pub_ro
  
  website {
    index_document = var.webpage_index
  }
}

resource "aws_s3_bucket_policy" "pub_ro" {
  bucket = aws_s3_bucket.webpage.id
  policy = jsonencode({
    Version = "2021-06-16"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.site.arn,
          "${aws_s3_bucket.webpage.arn}/*",
        ]
      },
    ]
  })
}
