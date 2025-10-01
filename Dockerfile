FROM python:3.11-alpine AS builder
WORKDIR /app
COPY requirements.txt .

RUN apk update && apk upgrade --no-cache

RUN pip install --upgrade "pip>=25.2" "setuptools>=78.1.1"

RUN pip install -r requirements.txt


FROM python:3.11-alpine
WORKDIR /app
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY app.py .

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 5000
CMD ["python", "app.py"]

