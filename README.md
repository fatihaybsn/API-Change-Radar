# API Change Radar

A FastAPI-based backend service that compares two OpenAPI specifications, detects meaningful API changes, classifies their risk level, stores the analysis in PostgreSQL, and exposes the result as JSON, Markdown, and a minimal HTML demo report.

![CI](https://github.com/fatihaybsn/API-Change-Radar/actions/workflows/ci.yml/badge.svg)
![Python 3.12](https://img.shields.io/badge/python-3.12-blue)
![FastAPI](https://img.shields.io/badge/FastAPI-0.115-009688)
![License: MIT](https://img.shields.io/badge/license-MIT-green)

---

## ⚡ Live Demo

> **Try it now →** [Open Swagger UI](https://api-change-radar.onrender.com/docs)
>
> Upload two OpenAPI specs, get a risk-classified change report in seconds.

| | |
|---|---|
| **Swagger UI** | https://api-change-radar.onrender.com/docs |
| **Health Check** | https://api-change-radar.onrender.com/healthz |
| **API Base** | https://api-change-radar.onrender.com/api/v1 |

> ⏳ **Cold start:** This demo runs on Render Free. The first request after inactivity may take up to 60 seconds while the container starts. Subsequent requests are fast.

---

## What This Project Does

API changes often create silent breakage, release risk, and integration problems. A plain text diff is not enough for real review.

API Change Radar answers:

* What changed between version A and version B?
* Which changes are likely to break consumers?
* Which changes are low-risk and which ones need review?
* Can the result be persisted and retrieved as a structured report?

---

## Key Features

* Deterministic diff and severity classification for OpenAPI specs
* JSON and YAML spec uploads
* PostgreSQL-backed persistence for runs, artifacts, and reports
* Structured report retrieval in JSON, Markdown, and HTML demo format
* Health, readiness, and Prometheus metrics endpoints
* Optional AI changelog interpretation (disabled by default, non-authoritative)
* Docker-first deployment with CI/CD pipeline

---

## Project Status

Current status: **live MVP demo / active iteration**

The core flow is fully operational: ingestion → validation → normalization → deterministic diff → severity classification → persistence → structured report retrieval. The project is actively maintained and deployed on Render.

---

## Try It Yourself

The fastest way to test the full analysis flow — no setup needed:

1. Open the [Swagger UI](https://api-change-radar.onrender.com/docs) (or `http://localhost:8000/docs` if running locally).
2. Expand **POST /api/v1/runs**.
3. Click **Try it out**.
4. Upload two OpenAPI spec files (you can use `examples/v1.yaml` and `examples/v2.yaml` from this repo).
5. Optionally enter a short `changelog_text`.
6. Click **Execute** — you will receive a `run_id`.
7. Use the returned `run_id` with these endpoints:
   - **GET /api/v1/runs/{run_id}** — check processing status
   - **GET /api/v1/reports/{run_id}** — fetch the structured JSON report
   - **GET /api/v1/reports/{run_id}?format=markdown** — Markdown export
   - **GET /api/v1/reports/{run_id}/demo** — minimal HTML demo report page

---

## Architecture Summary

Main parts of the system:

* **Ingestion API**: accepts two spec files and optional changelog text
* **Validator / Parser**: validates OpenAPI input and reads JSON/YAML
* **Normalizer**: converts specs into a canonical internal representation
* **Diff Engine**: computes deterministic findings
* **Severity Engine**: classifies findings into risk levels
* **Report Store**: persists runs, findings, artifacts, and report state
* **Read API**: returns structured reports and demo views
* **Observability Layer**: exposes structured logs, traces, and metrics

See [docs/architecture.md](docs/architecture.md) for more detail.

---

## Tech Stack

* Python 3.12
* FastAPI
* PostgreSQL
* SQLAlchemy + Alembic
* Docker / Docker Compose
* Pytest
* OpenTelemetry
* GitHub Actions

---

## Local Setup with Docker

### Prerequisites

* Docker Desktop or Docker Engine with Compose support

### Steps

```bash
git clone https://github.com/fatihaybsn/API-Change-Radar.git
cd API-Change-Radar
cp .env.example .env
docker compose pull
docker compose up -d
```

Once the stack is running, open:

* Health check: `http://localhost:8000/healthz`
* Swagger UI: `http://localhost:8000/docs`

The `docker-compose.yml` pulls the prebuilt image from Docker Hub (`fatihayibasan/api-change-radar:latest`). Database migrations run automatically on container startup.

To stop the stack:

```bash
docker compose down
```

To stop and remove data volumes:

```bash
docker compose down -v
```

---

## Development Setup

To build the image locally and modify source code:

```bash
docker compose -f docker-compose.dev.yml up --build -d
```

Stop with:

```bash
docker compose -f docker-compose.dev.yml down -v
```

Migrations run automatically. For manual migration outside Docker: `alembic upgrade head`.

---

## Example Usage with curl

Create a run:

```bash
curl -X POST http://localhost:8000/api/v1/runs \
  -F "specs=@examples/v1.yaml;type=application/yaml" \
  -F "specs=@examples/v2.yaml;type=application/yaml" \
  -F "changelog_text=Example changelog for demo"
```

Fetch the report (replace `<RUN_ID>` with the returned `run_id`):

```bash
curl http://localhost:8000/api/v1/reports/<RUN_ID>
curl "http://localhost:8000/api/v1/reports/<RUN_ID>?format=markdown"
```

Open the demo HTML report in the browser:

```
http://localhost:8000/api/v1/reports/<RUN_ID>/demo
```

---

## Design Principles

* Deterministic logic first
* Explicit over clever
* Narrow scope over broad ambition
* Tests for meaningful business logic
* Observability is part of the system
* AI is optional and non-authoritative

---

## CI & Testing

Automated CI via GitHub Actions on every push to `main` and every pull request:

* **Code quality:** formatting check with `ruff format --check` and linting with `ruff check`
* **Database:** migration validation with `alembic upgrade head`
* **Tests:** unit and integration tests covering diff engine, severity engine, API ingestion, report retrieval, run orchestration, health endpoints, and settings
* **Container:** Docker image build and end-to-end smoke test against a live stack

Run locally:

```bash
make check          # lint + test
./scripts/smoke.sh  # end-to-end smoke test
```

---

## Configuration

Configuration is managed via environment variables. Copy `.env.example` to `.env` for defaults — it includes all available options with sensible defaults.

Key settings:

| Variable | Default | Description |
|---|---|---|
| `APP_PORT` | `8000` | Host port exposed by Docker Compose |
| `ENVIRONMENT` | `development` | Runtime environment label |
| `ENABLE_LLM_CHANGELOG` | `false` | Optional AI changelog interpretation (deterministic results remain authoritative) |

See [.env.example](.env.example) for the full list.

---

## Troubleshooting

### `docker compose` says no configuration file provided

You are not inside the repository folder that contains `docker-compose.yml`. Move into the project folder first, then run:

```bash
docker compose pull
docker compose up -d
```

### Port 8000 is already in use

Change the host port in `.env`:

```env
APP_PORT=8001
```

Then restart:

```bash
docker compose up -d
```

### Health check works but there is no UI homepage

That is expected. This project is an API-first backend service. Use:

* `/docs` for Swagger UI
* `/redoc` for alternate docs
* `/api/v1/reports/<RUN_ID>/demo` for the report demo page

### Want to fully reset the stack?

```bash
docker compose down -v
```

---

## Author

Built by **Fatih Ayıbasan** as a backend-focused portfolio project.

* GitHub: [fatihaybsn](https://github.com/fatihaybsn)

---
