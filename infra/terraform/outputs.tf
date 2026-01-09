output "redshift_workgroup" {
  value = aws_redshiftserverless_workgroup.wg.workgroup_name
}

output "redshift_namespace" {
  value = aws_redshiftserverless_namespace.ns.namespace_name
}
