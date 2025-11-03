# Convenience targets for bq/gcloud routines
PROJECT_ID ?= your-gcp-project
DATASET ?= kimia_farma

.PHONY: dataset views analisa checks

dataset:
	bq --location=US mk --dataset "$(PROJECT_ID):$(DATASET)" || true

analisa:
	bq query --use_legacy_sql=false < sql/03_create_table_analisa.sql

views:
	for f in sql/views/*.sql; do bq query --use_legacy_sql=false < $$f; done

checks:
	bq query --use_legacy_sql=false < sql/99_quality_checks.sql
