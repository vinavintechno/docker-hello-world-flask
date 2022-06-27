FROM python:3.8.2-alpine3.11

ENV FLASK_APP=main.py
ENV FLASK_ENV=development

COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt



ENTRYPOINT FLASK_APP=/app/server.py flask run --host=0.0.0.0 --port=80
