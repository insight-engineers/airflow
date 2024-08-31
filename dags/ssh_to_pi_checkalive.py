import pendulum
from airflow import DAG
from airflow.providers.ssh.operators.ssh import SSHOperator

class NonTemplateSSHOperator(SSHOperator):
  template_fields = []

with DAG(
    dag_id="ssh_to_pi_checkalive",
    schedule='00 00 * * *',  # 00:00 GMT+7 Every Day
    start_date=pendulum.datetime(2024, 8, 30, tz="Asia/Ho_Chi_Minh"),
    tags=["ssh"]
) as dag:
    ssh_to_pi = NonTemplateSSHOperator(
        task_id='ssh_to_pi_checkalive',
        ssh_conn_id='ssh.pi.ubuntu.conn',
        cmd_timeout=1200,
        conn_timeout=1200,
        command='hostname && cat /etc/os-release',
        do_xcom_push=False
    )
    ssh_to_pi
