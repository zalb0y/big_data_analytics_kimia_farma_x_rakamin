-- Top 5 Cabang: Rating Cabang Tertinggi namun Rating Transaksi Terendah
-- Didefinisikan sebagai: rating_cabang tinggi tetapi rata-rata rating_transaksi relatif rendah
CREATE OR REPLACE VIEW `kimia_farma.view_top5_cabang_highbranch_lowtrans` AS
WITH agg AS (
  SELECT
    branch_id,
    ANY_VALUE(branch_name) AS branch_name,
    ANY_VALUE(kota) AS kota,
    ANY_VALUE(provinsi) AS provinsi,
    ANY_VALUE(rating_cabang) AS rating_cabang,
    AVG(rating_transaksi) AS avg_rating_transaksi,
    COUNT(*) AS transaksi
  FROM `kimia_farma.tabel_analisa`
  GROUP BY branch_id
)
SELECT *
FROM agg
WHERE rating_cabang >= 4.8  -- ambang "tinggi", sesuaikan bila perlu
ORDER BY avg_rating_transaksi ASC, transaksi DESC
LIMIT 5;
