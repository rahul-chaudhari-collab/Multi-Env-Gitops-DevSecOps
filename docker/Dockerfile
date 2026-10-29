FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PORT=5000
ENV PIP_NO_CACHE_DIR=1

WORKDIR /app

# Update available OS packages
RUN apt-get update && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

# Install and update Python packaging tools
COPY app/requirements.txt .

RUN python -m pip install --upgrade pip setuptools urllib3 msgpack && \
    pip install -r requirements.txt && \
    rm -f /usr/local/lib/python3.12/site-packages/pip/_vendor/bom.cdx.json

# Create a non-root application user
RUN useradd --create-home --shell /usr/sbin/nologin appuser

COPY app/src/ ./src/

RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "--access-logfile", "-", "--error-logfile", "-", "src.app:app"]
