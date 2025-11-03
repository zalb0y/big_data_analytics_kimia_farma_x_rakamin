# Data Dictionary (Ringkas)

## kf_final_transaction
- **transaction_id**: Kode id transaksi (STRING)
- **product_id**: Kode produk obat (STRING)
- **branch_id**: Kode id cabang (INT64)
- **customer_name**: Nama customer (STRING)
- **date**: Tanggal transaksi (DATE)
- **price**: Harga obat (NUMERIC/FLOAT64)
- **discount_percentage**: Persentase diskon (NUMERIC/FLOAT64, 0–100)
- **rating**: Rating transaksi (NUMERIC/FLOAT64)

## kf_product
- **product_id**: Kode produk (STRING)
- **product_name**: Nama produk (STRING)
- **product_category**: Kategori produk (STRING)
- **price**: Harga (INT64/NUMERIC)

## kf_kantor_cabang
- **branch_id**: Kode id cabang (INT64)
- **branch_category**: Kategori cabang (STRING)
- **branch_name**: Nama kantor cabang (STRING)
- **kota**: Kota (STRING)
- **provinsi**: Provinsi (STRING)
- **rating**: Rating cabang (NUMERIC/FLOAT64)

## kf_inventory
- **inventory_id**: Kode inventory (STRING)
- **branch_id**: Kode id cabang (INT64)
- **product_id**: Kode produk (STRING)
- **product_name**: Nama produk (STRING)
- **opname_stock**: Jumlah stok (INT64)

---

## tabel_analisa (mandatory)
- **transaction_id** (PK, NOT ENFORCED)
- **date** (DATE)
- **branch_id**, **branch_name**, **kota**, **provinsi**, **rating_cabang**
- **customer_name**
- **product_id**, **product_name**
- **actual_price**
- **discount_percentage**
- **persentase_gross_laba** (10/15/20/25/30)
- **nett_sales** = `actual_price * (1 - discount_percentage/100)`
- **nett_profit** = `nett_sales * persentase_gross_laba/100`
- **rating_transaksi**
