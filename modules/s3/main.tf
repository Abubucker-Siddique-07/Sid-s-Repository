resource "aws_s3_bucket" "my_terra_test_landing" {
    bucket = var.bucket_name
    force_destroy = true
    tags = {
        Name = var.bucket_tags.name_tag
        Description = var.bucket_tags.description_tag
    }
}

resource "aws_s3_bucket_acl" "my_terra_test_landing_acl" {
  bucket = aws_s3_bucket.my_terra_test_landing.id
  acl    = var.buket_acl
}