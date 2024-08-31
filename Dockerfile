ARG AIRFLOW_IMAGE_NAME=apache/airflow:slim-2.9.3
FROM ${AIRFLOW_IMAGE_NAME}

ENV AIRFLOW_HOME=/opt/airflow

WORKDIR $AIRFLOW_HOME

USER root
RUN apt-get update -qq && apt-get install vim -qqq && apt-get install -y python3-pip

ENV JAVA_HOME=/home/jdk-11.0.2

ENV PATH="${JAVA_HOME}/bin/:${PATH}"

RUN DOWNLOAD_URL="https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz" \
    && TMP_DIR="$(mktemp -d)" \
    && curl -fL "${DOWNLOAD_URL}" --output "${TMP_DIR}/openjdk-11.0.2_linux-x64_bin.tar.gz" \
    && mkdir -p "${JAVA_HOME}" \
    && tar xzf "${TMP_DIR}/openjdk-11.0.2_linux-x64_bin.tar.gz" -C "${JAVA_HOME}" --strip-components=1 \
    && rm -rf "${TMP_DIR}" \
    && java --version


COPY requirements.txt .

RUN python3 -m pip install --upgrade pip Cython setuptools wheel 
RUN python3 -m pip install --no-cache-dir psycopg2-binary==2.9.9 
RUN python3 -m pip install --no-cache-dir -r requirements.txt
RUN python3 -m pip install apache-airflow-providers-ssh

COPY bin scripts
RUN chmod +x scripts/*
COPY airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

USER $AIRFLOW_UID
