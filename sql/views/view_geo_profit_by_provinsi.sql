-- Geo Map: Total Profit per Provinsi
CREATE OR REPLACE VIEW `kimia_farma.view_geo_profit_by_provinsi` AS
SELECT
  provinsi,
  ROUND(SUM(nett_profit), 2) AS total_profit
FROM `kimia_farma.tabel_analisa`
GROUP BY provinsi
ORDER BY total_profit DESC;
