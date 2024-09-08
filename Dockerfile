ARG AIRFLOW_IMAGE_NAME=apache/airflow:slim-2.9.3
FROM ${AIRFLOW_IMAGE_NAME}

ENV AIRFLOW_HOME=/opt/airflow

WORKDIR $AIRFLOW_HOME

USER root
RUN apt-get update -qq && apt-get install vim -qqq && apt-get install -y python3-pip

COPY requirements.txt .

RUN python3 -m pip install --upgrade pip Cython setuptools wheel 
RUN python3 -m pip install --no-cache-dir psycopg2-binary==2.9.9 
RUN python3 -m pip install --no-cache-dir -r requirements.txt
RUN python3 -m pip install apache-airflow-providers-ssh

COPY bin scripts
RUN chmod +x scripts/*
COPY airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

USER $AIRFLOW_UID
