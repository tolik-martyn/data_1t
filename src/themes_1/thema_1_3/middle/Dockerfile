# Используем официальный образ PostgreSQL
FROM postgres:latest

# Определяем переменные среды для настройки базы данных
ENV POSTGRES_DB mydb
ENV POSTGRES_USER myuser
ENV POSTGRES_PASSWORD mypassword

# Создаем и привязываем том для данных PostgreSQL
VOLUME /var/lib/postgresql/data

# Копируем SQL-скрипт в контейнер
COPY init.sql /docker-entrypoint-initdb.d/

# Опционально, можно указать порт для PostgreSQL
# ENV POSTGRES_PORT 5432

# Опционально, можно указать настройки конфигурации PostgreSQL
# COPY postgresql.conf /etc/postgresql/postgresql.conf

# Запускаем PostgreSQL
CMD ["postgres"]