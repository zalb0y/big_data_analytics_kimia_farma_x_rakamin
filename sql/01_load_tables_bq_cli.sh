#!/usr/bin/env bash
set -euo pipefail

# Requires CSV already in GCS. Replace gs://your-bucket/....
PROJECT_ID="${PROJECT_ID:-your-gcp-project}"
DATASET="${DATASET:-kimia_farma}"
BUCKET="${BUCKET:-your-bucket}"

# Autodetect schema & parse dates
bq load --autodetect --source_format=CSV "$PROJECT_ID:$DATASET.kf_final_transaction" "gs://$BUCKET/kf_final_transaction.csv"
bq load --autodetect --source_format=CSV "$PROJECT_ID:$DATASET.kf_product" "gs://$BUCKET/kf_product.csv"
bq load --autodetect --source_format=CSV "$PROJECT_ID:$DATASET.kf_kantor_cabang" "gs://$BUCKET/kf_kantor_cabang.csv"
bq load --autodetect --source_format=CSV "$PROJECT_ID:$DATASET.kf_inventory" "gs://$BUCKET/kf_inventory.csv"

echo "Loaded 4 tables into $PROJECT_ID:$DATASET"
