#!/usr/bin/env bash
set -euo pipefail

# ======= CONFIG =======
PROJECT_ID="${PROJECT_ID:-your-gcp-project}"
LOCATION="${LOCATION:-US}"
DATASET="${DATASET:-kimia_farma}"
# ======================

echo "Enabling BigQuery API..."
gcloud services enable bigquery.googleapis.com --project "$PROJECT_ID"

echo "Creating dataset $PROJECT_ID:$DATASET in $LOCATION (if not exist)..."
bq --location="$LOCATION" mk --dataset "$PROJECT_ID:$DATASET" || true

echo "Done."
