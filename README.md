# Aws-S3-Redshift-Airflow-Datapipeline
# Project Overview

This project implements an end-to-end data pipeline that ingests CSV data from Amazon S3, orchestrates processing using Apache Airflow, loads data into Amazon Redshift Serverless, applies data quality checks, and exposes curated data for analytics in Power BI (PBIP).

The solution also includes CI/CD automation using GitHub Actions for linting, testing, and DAG validation.

# Architecture
# Data Flow

CSV → S3 (Raw)
        |
        v
   Apache Airflow
        |
        v
 Redshift Serverless
   ├─ Staging (Raw, untrusted)
   └─ Curated (Validated, trusted)
        |
        v
     Power BI (PBIP)

