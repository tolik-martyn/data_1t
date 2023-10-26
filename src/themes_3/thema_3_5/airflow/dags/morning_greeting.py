from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta

dag_id = 'my_simple_dag'

default_args = {
    'owner': 'Anatoliy',
    'start_date': datetime(2023, 10, 26),
    'retries': 1,
    'retry_delay': timedelta(minutes=1),
}

dag = DAG(
    dag_id,
    default_args=default_args,
    schedule_interval='*/10 * * * *',  # Запуск каждые 10 минут
    catchup=False,
)

task = BashOperator(
    task_id='print_message',
    bash_command='echo "Good morning my diggers!"',
    dag=dag,
)

task