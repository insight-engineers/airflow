pull:
	docker pull bitnami/spark:3.5.2
	docker pull gethue/hue:4.11.0
	docker pull postgres:13

update-connections:
	docker cp connections.json airflow-airflow-scheduler-1:/opt/airflow/connections.json
	docker exec -it airflow-airflow-scheduler-1 airflow connections import /opt/airflow/connections.json
