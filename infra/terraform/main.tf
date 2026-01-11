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
      Effect    = "Allow"
      Principal = { Service = "redshift.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "redshift_s3_policy" {
  role = aws_iam_role.redshift_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = ["s3:GetObject", "s3:ListBucket"]
      Resource = [
        aws_s3_bucket.raw_bucket.arn,
        "${aws_s3_bucket.raw_bucket.arn}/*"
      ]
    }]
  })
}

resource "aws_redshift_cluster" "redshift_cluster" {
  cluster_identifier  = "${var.project}-cluster"
  database_name       = "devdb"
  master_username     = "admin"
  master_password     = var.redshift_password
  node_type           = "dc2.large"
  cluster_type        = "single-node"
  iam_roles           = [aws_iam_role.redshift_role.arn]
  skip_final_snapshot = true
}
