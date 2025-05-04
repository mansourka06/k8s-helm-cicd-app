FROM python:alpine
WORKDIR /app
COPY app/ .
RUN pip install flask
CMD ["python", "main.py"]
