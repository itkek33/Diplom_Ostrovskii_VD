FROM python:3.9-slim

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    wget curl unzip gnupg \
    chromium chromium-driver \
    libnss3 libxss1 libasound2 libatk-bridge2.0-0 libatk1.0-0 \
    libx11-xcb1 libxcomposite1 libxdamage1 libxrandr2 \
    libgbm1 xdg-utils fonts-liberation --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Установка зависимостей Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копирование проекта
COPY . /app
WORKDIR /app

# Указываем путь к chromium, если требуется явно
ENV CHROME_BIN=/usr/bin/chromium

CMD ["python", "main.py"]
