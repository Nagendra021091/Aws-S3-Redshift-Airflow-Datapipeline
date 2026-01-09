output "bucket_name" {
  value = aws_s3_bucket.raw_bucket.bucket
}

output "redshift_role_arn" {
  value = aws_iam_role.redshift_role.arn
}
