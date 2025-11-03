# Kimia Farma — Business Performance Analytics (2020–2023)

Big Data Analytics X Rakamin | Google BigQuery + Looker Studio

Repository ini berisi _end-to-end_ materi untuk **analisis kinerja bisnis Kimia Farma tahun 2020–2023**:
skrip SQL BigQuery (setup dataset & load data, pembuatan `tabel_analisa`, dan views untuk dashboard),
panduan Looker Studio, _quality checks_.

> **Tujuan**  
> Mengevaluasi performa bisnis Kimia Farma 2020–2023 dan menyajikan insight yang dapat ditindaklanjuti
> bagi manajemen melalui dashboard interaktif (pendapatan, profit, aktivitas per provinsi/cabang, dan
> kepuasan transaksi).

---

## 🔎 Latar Belakang & Problem Statement

Sebagai jaringan farmasi nasional, Kimia Farma perlu pemantauan terukur atas pertumbuhan pendapatan,
efektivitas cabang, serta pengalaman pelanggan lintas wilayah. Analitik data historis membantu
mengidentifikasi tren, _outliers_, serta peluang perbaikan operasional maupun komersial.  

**Pertanyaan kunci (problem statement):**
- Bagaimana **tren pendapatan & laba per tahun (2020–2023)**?
- Provinsi mana yang **berkontribusi terbesar/terendah** pada **total transaksi** dan **nett sales**?
- Adakah **gap** antara **rating cabang** vs **rating transaksi**, dan **di mana lokasinya**?
- Bagaimana **sebaran total profit** per provinsi dan implikasi bisnisnya?

---

## 🗃️ Sumber Data

Empat dataset utama yang diimpor ke BigQuery:

- `kf_final_transaction.csv` — transaksi: `transaction_id`, `product_id`, `branch_id`, `customer_name`, `date`,
  `price`, `discount_percentage`, `rating`.
- `kf_product.csv` — master produk: `product_id`, `product_name`, `product_category`, `price`.
- `kf_kantor_cabang.csv` — master cabang: `branch_id`, `branch_category`, `branch_name`, `kota`, `provinsi`, `rating`.
- `kf_inventory.csv` — stok inventori: `inventory_id`, `branch_id`, `product_id`, `product_name`, `opname_stock`.

> **Catatan**: Deskripsi kolom di atas dirangkum dari dokumen _Hints_ (Data Dictionary).

---

## 🧱 Tabel Analisa (Mandatory Columns)

Tabel analisa dibangun dari hasil agregasi/join keempat tabel sumber memuat kolom berikut:

- `transaction_id`, `date`
- `branch_id`, `branch_name`, `kota`, `provinsi`, `rating_cabang`
- `customer_name`
- `product_id`, `product_name`
- `actual_price` (mengutamakan harga master produk; fallback ke harga transaksi)
- `discount_percentage` (0–100)
- `persentase_gross_laba` (aturan margin di bawah)
- `nett_sales` = `actual_price * (1 - discount_percentage/100)`
- `nett_profit` = `nett_sales * persentase_gross_laba/100`
- `rating_transaksi`

**Aturan persentase gross laba (berdasarkan harga aktual):**
- ≤ 50.000 → **10%**
- > 50.000–100.000 → **15%**
- > 100.000–300.000 → **20%**
- > 300.000–500.000 → **25%**
- > 500.000 → **30%**

Implementasi SQL tersedia di `sql/03_create_table_analisa.sql`.

---

## 📊 Dashboard (Google Looker Studio)

Dashboard **Performance Analytics Kimia Farma 2020–2023** dibangun dari `tabel_analisa` dan _views_
pendukung. **Komponen minimal** (sesuai brief _Challenging_):  

- **Judul** & **Summary** (ringkasan metrik)  
- **Filter Control** (mis. Tahun, Provinsi, Cabang, Kategori Produk)  
- **Snapshot Data** (tabel transaksi terbaru)  
- **Perbandingan Pendapatan YoY** (time series)  
- **Top 10 Total Transaksi per Provinsi** (bar chart)  
- **Top 10 Nett Sales per Provinsi** (bar chart)  
- **Top 5 Cabang** _Rating Cabang Tinggi_ namun _Rating Transaksi Rendah_ (table)  
- **Geo Map Indonesia** — **Total Profit per Provinsi**  

_SQL views_ untuk masing-masing visual telah disediakan di `sql/views/`:
- `view_yearly_revenue_profit.sql`
- `view_top10_transactions_by_provinsi.sql`
- `view_top10_nett_sales_by_provinsi.sql`
- `view_top5_cabang_highbranch_lowtrans.sql`
- `view_geo_profit_by_provinsi.sql`

---

## 🧪 Quality Checks

Gunakan `sql/quality_checks.sql` untuk memeriksa:
- **NULL check** pada kolom wajib
- **Duplikat** `transaction_id`
- **Sanity ranges** (min–max date, price, diskon, margin)

---

## 🗂️ Struktur Repository

```
.
├─ sql/
│  ├─ load_tables_bq_cli.sh
│  ├─ create_table_analisa.sql
│  ├─ quality_checks.sql
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
│  └─ PULL_REQUEST_TEMPLATE.md
├─ README.md
├─ .gitignore
├─ LICENSE
└─ Makefile
```

---

## 📄 Lisensi

MIT — lihat `LICENSE`.

---

## 🙌 Kredit

- Data & brief tugas: Kimia Farma X Rakamin (Project-Based Internship, 2020–2023).
- Teknologi: Google BigQuery, Google Looker Studio, Google Cloud SDK.

---

> Saran/masukan dipersilakan. Silakan buat **issue** atau **pull request** untuk perbaikan!
