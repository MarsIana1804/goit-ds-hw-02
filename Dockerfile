# Використовуємо офіційний образ Python (або інший відповідний образ)
FROM python:3.12

# Встановлення SQLite
RUN apt-get update && apt-get install -y sqlite3

# Створюємо робочу директорію
WORKDIR /app

# Копіюємо скрипт, який створює базу даних
COPY requirements.txt .

# Install dependencies from requirements.txt
RUN pip install -r requirements.txt

# Copy the script that creates the database
COPY seed.py .

# Команда за замовчуванням для запуску контейнера

CMD ["bash"]
