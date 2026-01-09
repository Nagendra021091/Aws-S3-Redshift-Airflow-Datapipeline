# Power BI (PBIP) Setup Guide

Redshift → Semantic Model → Report

# 1. What You Need
Prerequisites

Power BI Desktop (latest)
Redshift Serverless endpoint
Database: devdb
Schema: curated
Table: sales_summary

# 2. Connect Power BI to Redshift
Steps

Open Power BI Desktop
Click Get Data → Amazon Redshift
Enter:
  Server: our-workgroup-endpoint
  Database: devdb
Choose Import or DirectQuery
Select:
  curated.sales_summary
Click Load

# 3. Create PBIP Project

PBIP = Power BI Project (source-controlled)
Steps

File → Save As
Choose format: Power BI Project (.pbip)
Folder structure will look like:

powerbi/
├── SalesReport.pbip
├── SalesReport.Report/
└── SalesReport.SemanticModel/


This PBIP project connects to Amazon Redshift curated tables.

Measures:
- Total Sales:Total Sales = SUM(sales_summary[total_sales])
- Total Orders:Total Orders = SUM(sales_summary[total_orders])
- Avg Order Value:Avg Order Value = DIVIDE([Total Sales], [Total Orders])


Visuals:
- Sales trend by date
- KPI cards
- Summary table
