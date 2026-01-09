provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "raw_bucket" {
  bucket = "${var.project}-raw-data"
}

resource "aws_iam_role" "redshift_role" {
  name = "${var.project}-redshift-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "redshift.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_redshiftserverless_namespace" "ns" {
  namespace_name = "${var.project}-ns"
  db_name        = "devdb"
  iam_roles      = [aws_iam_role.redshift_role.arn]
}

resource "aws_redshiftserverless_workgroup" "wg" {
  workgroup_name = "${var.project}-wg"
  namespace_name = aws_redshiftserverless_namespace.ns.namespace_name
}
