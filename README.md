# Kimia Farma — Big Data Analytics (2020–2023)

Repository ini menampung *end-to-end* materi proyek **Performance Analytics Kimia Farma 2020–2023**: skrip BigQuery (DDL/DML), panduan Looker Studio, data dictionary, *quality checks*, dan template submission.

> **Ringkas**  
> - Data utama: `kf_final_transaction`, `kf_product`, `kf_kantor_cabang`, `kf_inventory`  
> - Target: membangun **tabel analisa** terstandar dan **dashboard** Looker Studio untuk periode 2020–2023  
> - Bahasa: SQL (Google BigQuery) + panduan
>
> **Struktur**  
> - `sql/` — DDL/DML BigQuery (setup dataset, load, pembuatan `tabel_analisa`, views untuk dashboard, dan quality checks)  
> - `scripts/` — Shell script contoh *infrastructure as commands* (gcloud/bq)  
> - `docs/` — Data Dictionary, ERD (Mermaid), Dashboard Guide, dan Submission Checklist  
> - `.github/` — Issue/PR templates
>
> **Terakhir diperbarui**: 2025-11-03

---

## 1) Quickstart

### A. Siapkan Project & Dataset BigQuery
```bash
# Aktifkan API BigQuery & buat dataset (ganti PROJECT_ID dan LOCATION)
gcloud services enable bigquery.googleapis.com
bq --location=US mk --dataset "$PROJECT_ID:kimia_farma"
```

Atau jalankan:
```bash
bash scripts/gcloud_bq_setup.sh
```

### B. *Load* 4 tabel sumber
- Opsi 1: Upload CSV ke **Cloud Storage** (mis. `gs://your-bucket/kf_*.csv`) lalu jalankan:
```bash
bash sql/01_load_tables_bq_cli.sh
```

- Opsi 2: UI BigQuery → *Create table* → *Upload* CSV, **Autodetect schema** atau gunakan skema eksplisit di `sql/02_schema_bigquery.sql`.

### C. Bangun tabel analisa + *views*
```bash
# Buat tabel analisa
bq query --use_legacy_sql=false < sql/03_create_table_analisa.sql

# Buat views pendukung dashboard
for f in sql/views/*.sql; do bq query --use_legacy_sql=false < "$f"; done
```

### D. Jalankan *quality checks*
```bash
bq query --use_legacy_sql=false < sql/99_quality_checks.sql
```

### E. Hubungkan ke Looker Studio
- Docs: `docs/DashboardGuide.md` (berisi mapping chart, filter, dan tips desain)

### F. Submission
- Ikuti `docs/SubmissionChecklist.md` untuk melengkapi file presentasi dan tautan yang diminta.

---

## 2) Struktur Folder
```
kimia-farma-bda-repo/
├─ sql/
│  ├─ 00_create_dataset.sql
│  ├─ 01_load_tables_bq_cli.sh
│  ├─ 02_schema_bigquery.sql
│  ├─ 03_create_table_analisa.sql
│  ├─ 99_quality_checks.sql
│  └─ views/
│     ├─ view_yearly_revenue_profit.sql
│     ├─ view_top10_transactions_by_provinsi.sql
│     ├─ view_top10_nett_sales_by_provinsi.sql
│     ├─ view_top5_cabang_highbranch_lowtrans.sql
│     └─ view_geo_profit_by_provinsi.sql
├─ scripts/
│  └─ gcloud_bq_setup.sh
├─ docs/
│  ├─ DataDictionary.md
│  ├─ ERD.md
│  ├─ DashboardGuide.md
│  └─ SubmissionChecklist.md
├─ .github/
│  ├─ ISSUE_TEMPLATE/
│  │  ├─ bug_report.md
│  │  └─ feature_request.md
│  └─ PULL_REQUEST_TEMPLATE.md
├─ .gitignore
├─ LICENSE
└─ Makefile
```

---

## 3) Catatan Desain
- **Penamaan konsisten** (snake_case), tipe data distandardisasi via `SAFE_CAST` & `COALESCE` di BigQuery.
- `discount_percentage` diperlakukan sebagai **persentase 0–100**.
- `persentase_gross_laba` disimpan sebagai **persentase** (10/15/20/25/30) dan dipakai dalam perhitungan `nett_profit = nett_sales * persentase_gross_laba/100`.
- *Left join* memastikan transaksi tidak lenyap saat data referensi produk/cabang kosong.

---

## 4) Lisensi & Kontribusi
- Lisensi: MIT (lihat `LICENSE`).
- Silakan buat issue/PR dengan template yang disediakan.

Happy analyzing! 🚀
