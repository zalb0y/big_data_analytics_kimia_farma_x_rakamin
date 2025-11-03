# Dashboard Guide (Google Looker Studio)

## Sumber Data
- Hubungkan ke BigQuery → `kimia_farma.tabel_analisa` dan views berikut:
  - `view_yearly_revenue_profit`
  - `view_top10_transactions_by_provinsi`
  - `view_top10_nett_sales_by_provinsi`
  - `view_top5_cabang_highbranch_lowtrans`
  - `view_geo_profit_by_provinsi`

## Komponen Wajib & Visual Rekomendasi
1. **Judul & Summary**: Skor ringkas (Total Revenue, Total Profit, Total Transaksi, Periode)
2. **Filter Control**: Tahun (EXTRACT(YEAR)), Provinsi, Cabang, Kategori Produk
3. **Snapshot Data**: Tabel 10 baris terbaru (sort `date` desc)
4. **Perbandingan Pendapatan YoY**: *Time series* dari `view_yearly_revenue_profit`
5. **Top 10 Total Transaksi per Provinsi**: *Bar chart* dari `view_top10_transactions_by_provinsi`
6. **Top 10 Nett Sales per Provinsi**: *Bar chart* dari `view_top10_nett_sales_by_provinsi`
7. **Top 5 Cabang: Rating Cabang Tinggi vs Rating Transaksi Rendah**: *Table* dari `view_top5_cabang_highbranch_lowtrans`
8. **Geo Map — Total Profit**: *Geo map* Indonesia dari `view_geo_profit_by_provinsi` (Field Geo: Provinsi)

## Field Terhitung (bila diperlukan)
- **tahun**: `EXTRACT(YEAR FROM date)`
- **margin_rate**: `persentase_gross_laba/100` (Number → Percent)

## Validasi Akhir
- Cross-check revenue/profit total vs. tabel summary (`view_yearly_revenue_profit`).
