FROM python:3.6-alpine

ENV APP_PORT=8081

EXPOSE 8081

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

ENV FLASK_APP='simple_api/simple_api.py'

CMD [ "flask", "run", "--host", "0.0.0.0", "--port", "8081" ]
