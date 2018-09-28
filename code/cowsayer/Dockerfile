FROM python:3.7.0-alpine
 
RUN pip install cowsay falcon gunicorn

COPY main.py /main.py

CMD ["gunicorn", "main:api", "--bind=0.0.0.0:8000", "--workers=2", "--threads=10"]
