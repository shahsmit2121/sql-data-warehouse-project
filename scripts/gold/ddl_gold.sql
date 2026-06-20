CREATE VIEW gold.dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY cci.cst_id) AS customer_key,
    cci.cst_id AS customer_id,
    cci.cst_key AS customer_number,
    cci.cst_firstname AS first_name,
    cci.cst_lastname AS last_name,
    ela.cntry AS country,
    cci.cst_marital_status AS marital_status,
    CASE
        WHEN cci.cst_gndr != 'n/a' THEN cci.cst_gndr
        ELSE COALESCE(eci.gen, 'n/a')
    END AS gender,
    eci.bdate AS birthdate,
    cci.cst_create_date AS create_date
FROM silver.crm_cust_info AS cci
LEFT JOIN
    silver.erp_cust_az12 AS eci
    ON cci.cst_key = eci.cid
LEFT JOIN
    silver.erp_loc_a101 AS ela
    ON cci.cst_key = ela.cid

--------------------------------------------------------------------

CREATE VIEW gold.dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY cpi.prd_start_dt, cpi.prd_key) AS product_key,
    cpi.prd_id AS product_id,
    cpi.prd_key AS product_number,
    cpi.prd_nm AS product_name,
    cpi.cat_id AS category_id,
    epc.cat AS category,
    epc.subcat AS subcategory,
    epc.maintenance AS maintenance,
    cpi.prd_cost AS product_cost,
    cpi.prd_line AS product_line,
    cpi.prd_start_dt AS start_date
FROM silver.crm_prd_info AS cpi
LEFT JOIN
    silver.erp_px_cat_g1v2 AS epc
    ON cpi.cat_id = epc.id
WHERE
    prd_end_dt IS NULL;

--------------------------------------------------------------------

CREATE VIEW gold.fact_sales AS
SELECT
    csd.sls_ord_num AS order_number,
    dpr.product_key,
    pcr.customer_key,
    csd.sls_order_dt AS order_date,
    csd.sls_ship_dt AS shipping_date,
    csd.sls_due_dt AS due_date,
    csd.sls_sales AS sales_amount,
    csd.sls_quantity AS quantity,
    csd.sls_price AS price
FROM silver.crm_sales_details AS csd
LEFT JOIN
    gold.dim_products AS dpr
    ON csd.sls_prd_key = dpr.product_number
LEFT JOIN
    gold.dim_customers AS pcr
    ON csd.sls_cust_id = pcr.customer_id;