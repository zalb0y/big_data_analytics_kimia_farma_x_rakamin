-- Basic data quality checks for kimia_farma.tabel_analisa

-- 1) Null check on mandatory columns
SELECT
  SUM(CASE WHEN transaction_id IS NULL THEN 1 ELSE 0 END) AS transaction_id_nulls,
  SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END) AS date_nulls,
  SUM(CASE WHEN branch_id IS NULL THEN 1 ELSE 0 END) AS branch_id_nulls,
  SUM(CASE WHEN customer_name IS NULL THEN 1 ELSE 0 END) AS customer_name_nulls,
  SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS product_id_nulls,
  SUM(CASE WHEN actual_price IS NULL THEN 1 ELSE 0 END) AS actual_price_nulls
FROM `kimia_farma.tabel_analisa`;

-- 2) Duplicate transaction_id
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT transaction_id) AS unique_transaction_id,
  COUNT(*) - COUNT(DISTINCT transaction_id) AS duplicate_transaction_id
FROM `kimia_farma.tabel_analisa`;

-- 3) Sanity ranges
SELECT
  MIN(date) AS min_date,
  MAX(date) AS max_date,
  MIN(actual_price) AS min_price,
  MAX(actual_price) AS max_price,
  MIN(discount_percentage) AS min_discount_pct,
  MAX(discount_percentage) AS max_discount_pct,
  MIN(persentase_gross_laba) AS min_gross_pct,
  MAX(persentase_gross_laba) AS max_gross_pct
FROM `kimia_farma.tabel_analisa`;
