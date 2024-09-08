ARG AIRFLOW_IMAGE_NAME=apache/airflow:slim-2.9.3
FROM ${AIRFLOW_IMAGE_NAME}

ENV AIRFLOW_HOME=/opt/airflow

WORKDIR $AIRFLOW_HOME

COPY requirements.txt .

RUN python3 -m pip install --no-cache-dir psycopg2-binary==2.9.9 apache-airflow-providers-ssh==3.13.1
RUN python3 -m pip install --no-cache-dir -r requirements.txt

USER root
COPY bin scripts
RUN chmod +x scripts/*
COPY airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

USER $AIRFLOW_UID
