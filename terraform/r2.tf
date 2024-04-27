resource "aws_s3_bucket" "default" {
  bucket = "iceberg-test"
}

resource "aws_s3_bucket_cors_configuration" "default" {
  bucket = aws_s3_bucket.default.id

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "default" {
  bucket = aws_s3_bucket.default.id

  rule {
    id     = "expire-bucket"
    status = "Enabled"
    expiration {
      days = 1
    }
  }

  rule {
    id     = "abort-multipart-upload"
    status = "Enabled"
    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }
  }
}
