-- Revenue & Profit per Year (2020–2023)
CREATE OR REPLACE VIEW `kimia_farma.view_yearly_revenue_profit` AS
SELECT
  EXTRACT(YEAR FROM date) AS tahun,
  ROUND(SUM(nett_sales), 2) AS revenue,
  ROUND(SUM(nett_profit), 2) AS profit,
  COUNT(*) AS transaksi
FROM `kimia_farma.tabel_analisa`
GROUP BY tahun
ORDER BY tahun;
