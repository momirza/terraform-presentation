FROM python:3.7.0-alpine
 
RUN pip install cowsay falcon gunicorn

COPY main.py /main.py

CMD ["gunicorn", "main:api", "-b 0.0.0.0:8000", "-w 2", "--access-logfile=-"]