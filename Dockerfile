FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY pyproject.toml README.md ./
COPY app ./app
COPY alembic ./alembic
COPY alembic.ini ./
COPY scripts ./scripts
COPY docker/entrypoint.sh /entrypoint.sh

RUN useradd -m -u 1000 appuser \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir . \
    && chmod +x /entrypoint.sh \
    && chown -R appuser:appuser /app /entrypoint.sh

USER appuser

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["sh", "-c", "uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-8000}"]