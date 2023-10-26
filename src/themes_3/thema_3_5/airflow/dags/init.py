from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.empty import EmptyOperator
from airflow.utils.task_group import TaskGroup

# аргументы DAG по умолчанию
default_args = {
    'owner': 'Anatoliy',
    'start_date': datetime(2023, 10, 26),
    'retries': 1,
    'retry_delay': timedelta(minutes=1),
}

with DAG(dag_id="init_variables_and_connections", default_args=default_args, schedule_interval='@once', catchup=False) as dag:
    start = EmptyOperator(task_id='start')
    with TaskGroup("init_variables_and_connections", tooltip="Добавление connections") as init_tg:
        set_variables = BashOperator(
            task_id = 'set_variables',
            bash_command='airflow variables import /opt/airflow/input/variables.json'
        )
        set_connections = BashOperator(
            task_id='set_connections',
            bash_command='airflow connections import /opt/airflow/input/connections.json'
        )
    end = EmptyOperator(task_id='end')
    start >> init_tg >> end