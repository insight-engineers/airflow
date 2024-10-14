from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator
from airflow.utils.dates import days_ago
from datetime import timedelta

default_args = {
    'owner': 'airflow',
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
    dag_id='hotel_recommendation_pipeline',
    default_args=default_args,
    description='A DAG with dummy tasks for crawling Booking.com, loading to BigQuery, transforming with dbt, and training a model.',
    schedule_interval='@daily',
    start_date=days_ago(1),
    catchup=False,
    tags=["pipeline", "dbt", "bigquery"]
) as dag: 

    # Dummy task for crawling data from Booking.com
    crawl_booking_com = DummyOperator(
        task_id='crawl_booking_com',
    )

    # Dummy task for loading data into BigQuery
    load_to_bigquery = DummyOperator(
        task_id='load_to_bigquery',
    )

    # Dummy task for transforming data with dbt
    transform_with_dbt = DummyOperator(
        task_id='transform_with_dbt',
    )

    # Dummy task for training the hotel recommendation model
    train_hotel_recommendation_model = DummyOperator(
        task_id='train_hotel_recommendation_model',
    )

    # Define task dependencies
    crawl_booking_com >> load_to_bigquery >> transform_with_dbt >> train_hotel_recommendation_model
