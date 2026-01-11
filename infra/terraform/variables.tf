variable "project" {
  description = "Project name prefix for AWS resources"
}

variable "region" {
  description = "AWS region for deployment"
}

variable "redshift_password" {
  description = "Master password for Redshift cluster"
  type        = string
  sensitive   = true
}
