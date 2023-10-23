import time
import psycopg2

time.sleep(10)

# Параметры подключения к базе данных
db_params = {
    'dbname': 'database',
    'user': 'username',
    'password': 'password',
    'host': 'db',
    'port': 5432
}

# Создаем подключение к базе данных
conn = psycopg2.connect(**db_params)

# Создаем курсор для выполнения SQL-запросов
cur = conn.cursor()

# SQL-запрос для создания новой таблицы
create_summary_table_query = """
CREATE TABLE IF NOT EXISTS currency_summary (
    max_date date,
    max_rate numeric,
    min_date date,
    min_rate numeric,
    avg_rate numeric,
    last_day_rate numeric,
    base_currency text,
    target_currency text,
    month_name text
);
"""
cur.execute(create_summary_table_query)

# Заполняем таблицу данными из таблицы currency_rates
populate_summary_table_query = """
INSERT INTO currency_summary (
    max_date,
    max_rate,
    min_date,
    min_rate,
    avg_rate,
    last_day_rate,
    base_currency,
    target_currency,
    month_name
)
SELECT
    (SELECT date FROM currency_rates WHERE rate = (SELECT MAX(rate) FROM currency_rates)),
    (SELECT MAX(rate) FROM currency_rates),
    (SELECT date FROM currency_rates WHERE rate = (SELECT MIN(rate) FROM currency_rates)),
    (SELECT MIN(rate) FROM currency_rates),
    (SELECT AVG(rate) FROM currency_rates),
    (SELECT rate FROM currency_rates WHERE date = '2023-09-30'),
    'BTC',
    'RUB',
    'September'
;
"""
cur.execute(populate_summary_table_query)

# Фиксируем изменения в базе данных
conn.commit()

# Закрываем курсор и соединение
cur.close()
conn.close()