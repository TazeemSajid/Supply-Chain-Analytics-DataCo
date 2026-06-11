-- 1. Average Delay by Region
SELECT 
    order_region,
    ROUND(CAST(AVG(delivery_delay_days) AS NUMERIC), 2) AS avg_delay,
    COUNT(*)                                             AS total_orders,
    SUM(delay_flag)                                      AS late_orders
FROM fact_orders
GROUP BY order_region
ORDER BY avg_delay DESC;

-- 2. Delay by Shipping Mode
SELECT 
    shipping_mode,
    ROUND(CAST(AVG(delivery_delay_days) AS NUMERIC), 2) AS avg_delay,
    COUNT(*)                                             AS total_orders,
    SUM(delay_flag)                                      AS late_orders,
    ROUND(CAST(SUM(delay_flag) * 100.0 / COUNT(*) AS NUMERIC), 2) AS late_pct
FROM fact_orders
GROUP BY shipping_mode
ORDER BY avg_delay DESC;

-- 3. Top 10 Most Delayed Products
SELECT 
    p.product_name,
    p.category_name,
    ROUND(CAST(AVG(f.delivery_delay_days) AS NUMERIC), 2) AS avg_delay,
    COUNT(*)                                               AS total_orders
FROM fact_orders f
JOIN dim_products p ON f.product_card_id = p.product_card_id
GROUP BY p.product_name, p.category_name
ORDER BY avg_delay DESC
LIMIT 10;

-- 4. Delay by Order Status
SELECT 
    order_status,
    COUNT(*)        AS total_orders,
    SUM(delay_flag) AS late_orders,
    ROUND(CAST(AVG(delivery_delay_days) AS NUMERIC), 2) AS avg_delay
FROM fact_orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- 5. Monthly Order Trend
SELECT 
    order_year,
    order_month,
    order_month_name,
    COUNT(DISTINCT order_id)                             AS total_orders,
    ROUND(CAST(SUM(sales) AS NUMERIC), 2)               AS total_sales,
    ROUND(CAST(AVG(delivery_delay_days) AS NUMERIC), 2) AS avg_delay
FROM fact_orders
GROUP BY order_year, order_month, order_month_name
ORDER BY order_year, order_month;