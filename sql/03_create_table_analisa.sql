-- Create analysis table per mandatory fields

CREATE OR REPLACE TABLE `kimia_farma.tabel_analisa`
PRIMARY KEY(transaction_id NOT ENFORCED) AS
WITH src AS (
  SELECT
    ft.transaction_id,
    DATE(ft.date) AS date,
    CAST(ft.branch_id AS INT64) AS branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    ft.customer_name,
    ft.product_id,
    p.product_name,
    -- Harga master produk lebih dipercaya; fallback ke harga transaksi
    COALESCE(SAFE_CAST(p.price AS NUMERIC), SAFE_CAST(ft.price AS NUMERIC)) AS actual_price,

    -- Pastikan persentase diskon dalam 0–100; NULL -> 0
    COALESCE(SAFE_CAST(ft.discount_percentage AS NUMERIC), 0) AS discount_percentage,

    -- Persentase gross laba berdasarkan harga aktual (dalam persen 10/15/20/25/30)
    CASE
      WHEN COALESCE(SAFE_CAST(p.price AS NUMERIC), SAFE_CAST(ft.price AS NUMERIC)) <= 50000 THEN 10
      WHEN COALESCE(SAFE_CAST(p.price AS NUMERIC), SAFE_CAST(ft.price AS NUMERIC)) <= 100000 THEN 15
      WHEN COALESCE(SAFE_CAST(p.price AS NUMERIC), SAFE_CAST(ft.price AS NUMERIC)) <= 300000 THEN 20
      WHEN COALESCE(SAFE_CAST(p.price AS NUMERIC), SAFE_CAST(ft.price AS NUMERIC)) <= 500000 THEN 25
      ELSE 30
    END AS persentase_gross_laba,

    -- Harga bersih setelah diskon (nett sales)
    COALESCE(SAFE_CAST(p.price AS NUMERIC), SAFE_CAST(ft.price AS NUMERIC)) * (1 - COALESCE(SAFE_CAST(ft.discount_percentage AS NUMERIC),0)/100.0) AS nett_sales,

    -- Profit bersih: nett_sales * persentase_gross_laba/100
    (COALESCE(SAFE_CAST(p.price AS NUMERIC), SAFE_CAST(ft.price AS NUMERIC)) * (1 - COALESCE(SAFE_CAST(ft.discount_percentage AS NUMERIC),0)/100.0))
      * (
        CASE
          WHEN COALESCE(SAFE_CAST(p.price AS NUMERIC), SAFE_CAST(ft.price AS NUMERIC)) <= 50000 THEN 10
          WHEN COALESCE(SAFE_CAST(p.price AS NUMERIC), SAFE_CAST(ft.price AS NUMERIC)) <= 100000 THEN 15
          WHEN COALESCE(SAFE_CAST(p.price AS NUMERIC), SAFE_CAST(ft.price AS NUMERIC)) <= 300000 THEN 20
          WHEN COALESCE(SAFE_CAST(p.price AS NUMERIC), SAFE_CAST(ft.price AS NUMERIC)) <= 500000 THEN 25
          ELSE 30
        END
      ) / 100.0 AS nett_profit,

    -- Rating transaksi dari ft
    SAFE_CAST(ft.rating AS NUMERIC) AS rating_transaksi

  FROM `kimia_farma.kf_final_transaction` ft
  LEFT JOIN `kimia_farma.kf_product` p
    ON ft.product_id = p.product_id
  LEFT JOIN `kimia_farma.kf_kantor_cabang` kc
    ON CAST(ft.branch_id AS INT64) = kc.branch_id
)
SELECT * FROM src;
