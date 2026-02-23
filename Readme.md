<!-- Hero -->
![logo](assets/illustrations/logo.svg)

# Intermediate SQL for Data Science — PostgreSQL + Kaggle

Colorful, project-based learning for intermediate SQL with local PostgreSQL and real Kaggle CSVs (Airbnb, US Accidents). Build ETL pipelines, optimize queries, and produce data stories for your portfolio.

---

<!-- Badges & CTA -->
[![Postgres](https://img.shields.io/badge/Postgres-local-blue)](tools/README.md) [![Kaggle](https://img.shields.io/badge/Kaggle-data-orange)](https://www.kaggle.com) [![Jupyter](https://img.shields.io/badge/Jupyter-notebooks-orange)](notebooks/)

**Get started**
- Quick setup: see [tools/README.md](tools/README.md) (Postgres installer + local configuration).
- Place Kaggle CSVs in `C:\data\` (see [data/README.md](data/README.md)).
- Open the example notebooks in `notebooks/` or run SQL via `psql`.

---

## Table of Contents
- [Syllabus](SYLLABUS.md)
- [Quickstart](#quickstart)
- [Project Structure](#project-structure)
- [Progress Tracker](#progress-tracker)
- [Capstone](projects/capstone/README.md)
- [Contributing](CONTRIBUTING.md)

---

## Quickstart

1. Install PostgreSQL for Windows (EnterpriseDB) and pgAdmin if desired — see `tools/README.md`.
2. Create DB and user (docs use `airbnb_user` / `StrongP@ssw0rd` placeholders).
3. Place CSVs in `C:\data\`.

PowerShell example: import a CSV using `psql` (client-side copy):

```powershell
psql -U airbnb_user -d airbnb_db -h localhost -c "\copy staging.airbnb_raw FROM 'C:\\data\\train_users_2.csv' WITH (FORMAT csv, HEADER true)"
psql -U airbnb_user -d airbnb_db -h localhost -c "\copy staging.us_accidents_raw FROM 'C:\\data\\US_Accidents_Dec20_updated.csv' WITH (FORMAT csv, HEADER true)"
```

If you prefer GUI, use pgAdmin to run the same COPY commands from its Query Tool.

---

## Project Structure
- `SYLLABUS.md` — ordered module plan and learning objectives
- `tools/README.md` & `data/README.md` — local setup and data placement
- `sql/projects/` — schema, ETL, analytics SQL files (organized by module)
- `notebooks/` — full-solution Jupyter notebooks (Airbnb, US Accidents, SQL workshop)
- `projects/capstone/` — capstone prompt, SQL & notebook
- `assets/` — hero SVG, thumbnails, ER diagrams
- `.github/workflows/ci.yml` & `ci/` — CI lint and smoke-test stubs

---

## Progress Tracker
Follow along and check off modules as you complete them.

- [x] 1. Relational modeling & advanced JOINs
- [x] 2. Aggregations, GROUP BY, ROLLUP
- [x] 3. Window functions & ranking
- [x] 4. CTEs & modular SQL
- [x] 5. ETL patterns & upserts
- [x] 6. Indexing & EXPLAIN
- [x] 7. JSONB & geospatial features
- [x] 8. Testing & CI for SQL
- [ ] 9. Capstone — end-to-end project

---

## Visuals & Portfolio Tips
- Use `assets/illustrations/logo.svg` and `assets/er/` for ER diagrams.
- Add a short write-up and key SQL snippets to each module's README to showcase on your portfolio.
- Consider exporting key notebook visualizations as PNG and adding thumbnails under `assets/`.

---

## License
See `LICENSE`.

---

If you want, I can now populate the SQL lesson files with full ETL and analytics examples or add small demo CSV extracts (<1MB) for quick runs — tell me which next.

