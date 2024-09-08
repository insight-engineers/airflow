update-connections:
	docker cp connections.json centerm_airflow-scheduler:/opt/airflow/connections.json
	docker exec -it centerm_airflow-scheduler airflow connections import /opt/airflow/connections.json
