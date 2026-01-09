from airflow.models import DagBag
import os

def test_dag_loaded():
    dags_path = os.path.join(os.getcwd(), "airflow", "dags")
    dagbag = DagBag(dag_folder=dags_path, include_examples=False)

    assert "s3_to_redshift_pipeline" in dagbag.dags
