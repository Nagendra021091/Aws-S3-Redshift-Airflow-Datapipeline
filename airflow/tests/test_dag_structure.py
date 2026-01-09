from airflow.models import DagBag

def test_dag_loaded():
    dagbag = DagBag()
    assert "s3_to_redshift_pipeline" in dagbag.dags
