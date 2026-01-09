from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import psycopg2
import os


def load_to_redshift():
    print("Connecting to Redshift...")

    conn = psycopg2.connect(
        host=os.environ.get("REDSHIFT_HOST"),
        dbname=os.environ.get("REDSHIFT_DB"),
        user=os.environ.get("REDSHIFT_USER"),
        password=os.environ.get("REDSHIFT_PASSWORD"),
        port=5439
    )

    cur = conn.cursor()

    print("Running COPY command...")

    copy_sql = f"""
        COPY staging.sales_orders
        FROM 's3://{os.environ.get("S3_BUCKET")}/raw/sales_orders/'
        IAM_ROLE '{os.environ.get("REDSHIFT_ROLE_ARN")}'
        CSV IGNOREHEADER 1;
    """

    try:
        cur.execute(copy_sql)
        conn.commit()
        print("Data load completed successfully.")
    except Exception as e:
        print("Error loading data:", e)
        raise
    finally:
        cur.close()
        conn.close()


with DAG(
    dag_id="s3_to_redshift_pipeline",
    start_date=datetime(2026, 1, 1),
    schedule_interval=None,
    catchup=False
) as dag:

    load_task = PythonOperator(
        task_id="load_s3_to_redshift",
        python_callable=load_to_redshift
    )
