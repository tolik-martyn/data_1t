import requests
import pandas as pd
import psycopg2

# API-ключ
api_key = 'da05172f423e6ed8a0fd1e0c239c4674'

# Параметры запроса
start_date = '2023-09-01'
end_date = '2023-09-30'
base_currency = 'BTC'
target_currency = 'RUB'
format = 1

# URL API
api_url = 'http://api.exchangerate.host/timeframe'

# Параметры запроса
params = {
    'access_key': api_key,
    'source': base_currency,
    'currencies': target_currency,
    'start_date': start_date,
    'end_date': end_date,
    'format': format
}

# Отправка GET-запроса
response = requests.get(api_url, params=params)

# Проверка статуса ответа
if response.status_code == 200:
    # Преобразование JSON-ответа в словарь
    data = response.json()
    # Получение курсов валют
    quotes = data["quotes"]
else:
    print("Ошибка при запросе к API. Код состояния:", response.status_code)
    quotes = {}

# Список для хранения данных
data_list = []

# Перебор дат и их соответствующих курсов
for date, rate_data in quotes.items():
    for currency_pair, rate in rate_data.items():
        data_list.append([date, currency_pair, rate])

# Создание DataFrame из списка
df = pd.DataFrame(data_list, columns=["Дата", "Валютная пара", "Курс"])

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

# Создаем таблицу, если она не существует
create_table_query = """
CREATE TABLE IF NOT EXISTS currency_rates (
    id serial PRIMARY KEY,
    date date,
    base_currency text,
    target_currency text,
    rate numeric
);
"""
cur.execute(create_table_query)

# Переносим данные в таблицу
for date, rate_data in quotes.items():
    base_currency, rate = list(rate_data.items())[0]
    target_currency = "RUB"  # целевая валюта
    insert_query = "INSERT INTO currency_rates (date, base_currency, target_currency, rate) VALUES (%s, %s, %s, %s);"
    cur.execute(insert_query, (date, base_currency, target_currency, rate))

# Фиксируем изменения в базе данных
conn.commit()

# Закрываем курсор и соединение
cur.close()
conn.close()