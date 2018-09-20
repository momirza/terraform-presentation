FROM ubuntu:16.04

RUN apt-get update && apt-get install -y python-pip

RUN pip install -U pymongo==3.6.0

RUN pip install flask==0.12.2

WORKDIR /app

COPY ./app /app

CMD ["flask", "run", "--host=0.0.0.0"]
