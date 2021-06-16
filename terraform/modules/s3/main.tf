resource "aws_s3_bucket" "webpage" {
  bucket = var.webpage_domain
  acl = "public-read"
  website {
    index_document = var.webpage_index
  }
}

resource "aws_s3_bucket_policy" "pub_ro" {
  bucket = aws_s3_bucket.webpage.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.webpage.arn,
          "${aws_s3_bucket.webpage.arn}/*",
        ]
      },
    ]
  })
}

resource "aws_s3_bucket_object" "index.html" {
  bucket = aws_s3_bucket.webpage.id
  key = var.webpage_index
  content = var.webpage_index_content
}
