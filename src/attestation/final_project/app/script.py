# -*- coding: utf-8 -*-

import pandas as pd
import psycopg2
import matplotlib.pyplot as plt
import seaborn as sns
import time

# Задержка на 3 минуты, чтобы успели отработать sql-скрипты из final_project/init
time.sleep(180)

db_name = 'database'
db_user = 'username'
db_pass = 'password'
db_host = 'postgres'
db_port = '5432'

db_string = 'postgres://{}:{}@{}:{}/{}'.format(db_user, db_pass, db_host, db_port, db_name)

# чтение витрины по анализу поездок по группам пассажиров
with psycopg2.connect(db_string) as conn:
    cursor = conn.cursor()
    cursor.execute('''SELECT * FROM percentage_max_min_data''')
    p = cursor.fetchall()
conn.close()

df = pd.DataFrame(p, columns=['date',
                              'percentage_zero',
                              'max_amount_zero',
                              'min_amount_zero',
                              'percentage_1p',
                              'max_amount_1p',
                              'min_amount_1p',
                              'percentage_2p',
                              'max_amount_2p',
                              'min_amount_2p',
                              'percentage_3p',
                              'max_amount_3p',
                              'min_amount_3p',
                              'percentage_4p_plus',
                              'max_amount_4p_plus',
                              'min_amount_4p_plus'
                             ])

df.to_csv(r'/result_data/percentage_max_min_data.parquet', index=None)

# чтение витрины по анализу зависимости чаевых от количества пассажиров и длины поездки
with psycopg2.connect(db_string) as conn:
    cursor = conn.cursor()
    cursor.execute('''SELECT * FROM tip_data''')
    p = cursor.fetchall()
conn.close()

# подготовка данных для визуализации
df = pd.DataFrame(p, columns=['passanger_count_group', 'trip_distance_group', 'avg_tip_amount'])
df = df.pivot(index='trip_distance_group', values='avg_tip_amount', columns='passanger_count_group')

# визуализация
plt.figure(figsize=(10,8))
sns.heatmap(df, linewidths=.5, annot=True, cmap='coolwarm', fmt = '.3g')
plt.xlabel('Количество пассажиров, чел', size=12)
plt.ylabel('Дальность поездки, ед', size=12)
plt.title('Средние чаевые, ден. ед', size=14)

plt.savefig(r'/result_data/tip_data.png')