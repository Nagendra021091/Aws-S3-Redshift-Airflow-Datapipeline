from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import psycopg2

def load_to_redshift():
    conn = psycopg2.connect(
        host="our-redshift-endpoint",
        dbname="devdb",
        user="admin",
        password="password",
        port=5439
    )
    cur = conn.cursor()

    cur.execute("""
        COPY staging.sales_orders
        FROM 's3://raw_bucket/raw/sales_orders/'
        IAM_ROLE 'your-role-arn'
        CSV IGNOREHEADER 1;
    """)

    conn.commit()
    cur.close()
    conn.close()

with DAG(
    dag_id="s3_to_redshift_pipeline",
    start_date=datetime(2024, 1, 1),
    schedule_interval=None,
    catchup=False
) as dag:

    load_task = PythonOperator(
        task_id="load_s3_to_redshift",
        python_callable=load_to_redshift
    )
