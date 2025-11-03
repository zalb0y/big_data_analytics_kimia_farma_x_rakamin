-- Explicit schema definitions (use with CREATE TABLE AS SELECT from external stage or for validation)

-- kf_final_transaction
-- Columns: transaction_id STRING, product_id STRING, branch_id INT64, customer_name STRING, date STRING/DATE, price NUMERIC/FLOAT64, discount_percentage NUMERIC/FLOAT64, rating NUMERIC/FLOAT64

-- kf_product
-- Columns: product_id STRING, product_name STRING, product_category STRING, price INT64/NUMERIC

-- kf_kantor_cabang
-- Columns: branch_id INT64, branch_category STRING, branch_name STRING, kota STRING, provinsi STRING, rating NUMERIC/FLOAT64

-- kf_inventory
-- Columns: inventory_id STRING, branch_id INT64, product_id STRING, product_name STRING, opname_stock INT64
