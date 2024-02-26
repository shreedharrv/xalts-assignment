FROM python:3.9-slim

WORKDIR /app

COPY . /app

RUN pip install --trusted-host pypi.python.org Flask

EXPOSE 5000

CMD ["python", "app.py"]