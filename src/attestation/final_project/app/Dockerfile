FROM python:3.9

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы приложения в контейнер
COPY . /app

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Определение переменных окружения
ENV PYTHONUNBUFFERED 1

# Команда для запуска приложений
# CMD ["python", "script.py"]
