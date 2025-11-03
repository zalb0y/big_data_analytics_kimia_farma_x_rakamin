-- Top 10 Total Transaksi per Provinsi
CREATE OR REPLACE VIEW `kimia_farma.view_top10_transactions_by_provinsi` AS
SELECT
  provinsi,
  COUNT(*) AS total_transaksi
FROM `kimia_farma.tabel_analisa`
GROUP BY provinsi
ORDER BY total_transaksi DESC
LIMIT 10;
