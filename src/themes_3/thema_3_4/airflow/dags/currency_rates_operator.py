from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime, timedelta
import requests
import psycopg2

dag_id = 'currency_exchange_dag'

default_args = {
    'owner': 'Anatoliy',
    'start_date': datetime(2023, 10, 23),
    'retries': 1,
    'retry_delay': timedelta(minutes=1),
}

dag = DAG(
    dag_id,
    default_args=default_args,
    schedule_interval='*/10 * * * *',  # Запуск каждые 10 минут
    catchup=False,
)

# Создание таблицы
def create_currency_rates_table():
    db_params = {
        'dbname': 'airflow',
        'user': 'airflow',
        'password': 'airflow',
        'host': 'postgres',
        'port': 5432
    }

    conn = psycopg2.connect(**db_params)
    cur = conn.cursor()

    create_table_query = """
    CREATE TABLE IF NOT EXISTS currency_rates (
        id serial PRIMARY KEY,
        timestamp timestamp,
        source text,
        currencies text,
        rate numeric
    );
    """
    cur.execute(create_table_query)

    conn.commit()
    cur.close()
    conn.close()

# Оператор, который выполнит функцию create_currency_rates_table
create_table_operator = PythonOperator(
    task_id='create_currency_table',
    python_callable=create_currency_rates_table,
    dag=dag,
)

# Функция для получения курсов валют и записи в базу данных
def fetch_currency_and_save_to_db():
    api_url = 'http://api.exchangerate.host/live'
    api_key = 'da05172f423e6ed8a0fd1e0c239c4674'
    base_currency = 'BTC'
    target_currency = 'RUB'
    format = 1
    params = {
        'access_key': api_key,
        'source': base_currency,
        'currencies': target_currency,
        'format': format
    }

    response = requests.get(api_url, params=params)

    if response.status_code == 200:
        data = response.json()
        quotes = data["quotes"]
        timestamp = datetime.fromtimestamp(data["timestamp"])
        rate = quotes.get(f"{base_currency}{target_currency}")

        db_params = {
            'dbname': 'airflow',
            'user': 'airflow',
            'password': 'airflow',
            'host': 'postgres',
            'port': 5432
        }

        conn = psycopg2.connect(**db_params)
        cur = conn.cursor()

        insert_query = """
        INSERT INTO currency_rates (timestamp, source, currencies, rate)
        VALUES (%s, %s, %s, %s);
        """
        cur.execute(insert_query, (timestamp, base_currency, target_currency, rate))

        conn.commit()
        cur.close()
        conn.close()
    else:
        print("Ошибка при запросе к API. Код состояния:", response.status_code)


# Оператор, который выполнит функцию fetch_currency_and_save_to_db
fetch_currency_operator = PythonOperator(
    task_id='fetch_currency',
    python_callable=fetch_currency_and_save_to_db,
    dag=dag,
)

create_table_operator >> fetch_currency_operator