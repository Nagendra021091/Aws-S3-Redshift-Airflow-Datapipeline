output "bucket_name" {
  value = aws_s3_bucket.raw_bucket.bucket
}

output "redshift_role_arn" {
  value = aws_iam_role.redshift_role.arn
}

output "redshift_cluster_endpoint" {
  value = aws_redshift_cluster.redshift_cluster.endpoint
}

output "redshift_cluster_id" {
  value = aws_redshift_cluster.redshift_cluster.id
}
