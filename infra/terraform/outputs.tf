output "bucket_name" {
  value = aws_s3_bucket.raw_bucket.bucket
}

output "redshift_role_arn" {
  value = aws_iam_role.redshift_role.arn
}

output "redshift_workgroup" {
  value = aws_redshiftserverless_workgroup.wg.workgroup_name
}

output "redshift_namespace" {
  value = aws_redshiftserverless_namespace.ns.namespace_name
}
