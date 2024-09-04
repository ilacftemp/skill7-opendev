FROM python:3.9.13
WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y \
sqlite3 \
&& rm -rf /var/lib/apt/lists/*
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 80
RUN ! -f "/app/quiz.db" && touch /app/quiz.db
RUN sqlite3 /app/quiz.db < /app/quiz.sql
RUN python adduser.py
CMD ["python", "softdes.py"]