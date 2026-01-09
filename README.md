# Aws-S3-Redshift-Airflow-Datapipeline
# Project Overview

This project implements an end-to-end data pipeline that ingests CSV data from Amazon S3, orchestrates processing using Apache Airflow, loads data into Amazon Redshift Serverless, applies data quality checks, and exposes curated data for analytics in Power BI (PBIP).

The solution also includes CI/CD automation using GitHub Actions for linting, testing, and DAG validation.

# Architecture
# Data Flow

CSV → S3 (Raw)
        |
        
   Apache Airflow
        |
        
 Redshift Serverless
   ├─ Staging (Raw, untrusted)
   └─ Curated (Validated, trusted)
        |
        
     Power BI (PBIP)
     
# CI/CD Flow

GitHub Push / PR
        |
  GitHub Actions
   ├─ Lint
   ├─ DAG Import Test
   └─ Unit Tests
   
# Repository Structure

.
├─ infra/terraform/        # AWS infrastructure (S3, IAM, Redshift)
├─ airflow/               # Airflow DAGs + Docker setup + tests
├─ sql/                   # Schemas, DDL, quality checks
├─ powerbi/               # PBIP project
├─ data/sample/           # Sample CSV data
├─ docs/                  # Screenshots & evidence
└─ .github/workflows/     # CI/CD pipeline

# Infrastructure Setup (Terraform)
  # Prerequisites

1.AWS CLI configured
2.Terraform installed

# Commands

cd infra/terraform
terraform init
terraform apply -var="project=pre-assessment" -var="region=eu-west-2"

# Outputs

 Terraform will output:

S3 bucket name
IAM Role ARN
Redshift Serverless workgroup

These values are used by Airflow and Redshift.

# Airflow Setup
  # Start Airflow

cd airflow
docker compose up -d

# Access UI

http://localhost:8080  
User:  
Pass: 

# Upload Sample Data to S3

aws s3 cp data/sample/sales_orders.csv \
s3:///raw/sales_orders/sales_orders_test.csv




   

     

