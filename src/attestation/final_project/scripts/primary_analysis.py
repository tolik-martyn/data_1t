# -*- coding: utf-8 -*-
# Первичный анализ данных
import pandas as pd

file_name = 'final_project/raw/yellow_tripdata_2020-01.csv'
df = pd.read_csv(file_name)

print(df.head())

# Информация о данных
print(df.info())

# Сводная статистика
print(df.describe())

# Выбор столбцов с типом данных 'object'
object_columns = df.select_dtypes(include=['object']).columns

# Вывод уникальных значений в каждом столбце типа 'object'
for column in object_columns:
    print(f"Уникальные значения в столбце {column}:\n{df[column].unique()}\n")

# Вывод общей информации о данных типа 'object'
print(df[object_columns].info())