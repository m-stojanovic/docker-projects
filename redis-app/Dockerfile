FROM python:3.7-alpine

ADD . /code

WORKDIR /code

RUN pip install -r flask redis

CMD ["python", "app.py"]
