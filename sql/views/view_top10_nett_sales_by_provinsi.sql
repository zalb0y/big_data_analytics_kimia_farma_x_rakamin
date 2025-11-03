-- Top 10 Nett Sales per Provinsi
CREATE OR REPLACE VIEW `kimia_farma.view_top10_nett_sales_by_provinsi` AS
SELECT
  provinsi,
  ROUND(SUM(nett_sales), 2) AS nett_sales
FROM `kimia_farma.tabel_analisa`
GROUP BY provinsi
ORDER BY nett_sales DESC
LIMIT 10;
