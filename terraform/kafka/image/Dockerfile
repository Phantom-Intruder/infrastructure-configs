FROM python:alpine3.16
COPY kafka-python.py .
RUN pip install kafka-python
ENTRYPOINT ["python", "kafka-python.py"]
