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
└─ .github/workflows/     # CI/CD pipeline

# Infrastructure Setup (Terraform)
  # Prerequisites

1.AWS CLI configured
2.Terraform installed

# Commands

cd infra/terraform
terraform init
terraform apply -var="project=pre-assessment" -var="region=us-east-1"

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
s3://raw_bucket/raw/sales_orders/sales_orders_test.csv

This places the raw CSV in S3 for ingestion.

# Run the Pipeline

Open Airflow UI
Trigger DAG: s3_to_redshift_pipeline
Monitor logs

Airflow loads data into staging tables, runs quality checks, and promotes clean data to curated table

# Data Quality Checks

The pipeline validates:

Null values
Duplicates
Schema consistency

Example:

SELECT COUNT(*) 
FROM staging.sales_orders 
WHERE order_id IS NULL;

Expected Result: 0

If checks fail:

❌ Curated tables are NOT updated
✔ Previous curated data remains available

# Rollback & Failure Handling
Strategy

Data loads into staging tables
Quality checks are executed
Only clean data is promoted to curated tables

If any step fails:

Pipeline stops
Curated tables remain unchanged
Dashboards continue using old data
Pipeline can be safely re-run

# Idempotent Loads

TRUNCATE TABLE staging.sales_orders;
COPY staging.sales_orders FROM S3;

This ensures:

No duplicates
No partial data
Safe retries

# Logging & Observability

Airflow provides:

Task-level logs
Error traces
Execution history

# Power BI (PBIP)
Setup

Connect to Redshift curated schema
Save project as PBIP for version control

Measures
Total Sales = SUM(sales_summary[total_sales])
Total Orders = SUM(sales_summary[total_orders])
Avg Order Value = DIVIDE([Total Sales], [Total Orders])

# Report

Includes:

Sales trend line chart
KPI cards
Summary table

# CI/CD Pipeline (GitHub Actions)

On every push / pull request, the pipeline runs:

Python linting
DAG import tests
Unit tests

Pipeline file: .github/workflows/ci.yml

This ensures:

✔ Code quality
✔ DAG validity
✔ Early error detection

# Troubleshooting
If DAG is not visable  we need to restart Airflow
If COPY Fails we need to chekc Check IAM role + S3 path
If RedShift connection fails we need to Verify endpoint + port
If PoerBi having any issues we need to check and Confirm schema + permissions

# Cleanup

To destroy AWS resources:

cd infra/terraform
terraform destroy -auto-approve







   

     

