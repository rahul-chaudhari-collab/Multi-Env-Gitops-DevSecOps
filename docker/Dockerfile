# Stage 1: Build Python dependencies
FROM python:3.12-alpine AS builder

WORKDIR /build

COPY app/requirements.txt .

RUN python -m venv /opt/venv && \
    /opt/venv/bin/pip install --no-cache-dir -r requirements.txt

# Stage 2: Minimal production runtime
FROM python:3.12-alpine AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=5000 \
    PATH="/opt/venv/bin:$PATH"

WORKDIR /app

RUN apk upgrade --no-cache && \
    adduser -D -h /home/appuser -s /sbin/nologin appuser

COPY --from=builder /opt/venv /opt/venv
COPY app/src/ ./src/

RUN rm -rf /opt/venv/lib/python3.12/site-packages/pip* && \
    chown -R appuser:appuser /app /opt/venv

USER appuser

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "--access-logfile", "-", "--error-logfile", "-", "src.app:app"]
