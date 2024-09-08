update-connections:
	docker cp connections.json airflow-airflow-scheduler-1:/opt/airflow/connections.json
	docker exec -it airflow-airflow-scheduler-1 airflow connections import /opt/airflow/connections.json
