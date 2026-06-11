-- 1. Profit by Category
SELECT 
    p.category_name,
    ROUND(CAST(SUM(f.benefit_per_order) AS NUMERIC), 2)  AS total_profit,
    ROUND(CAST(SUM(f.sales) AS NUMERIC), 2)              AS total_sales,
    ROUND(CAST(AVG(f.profit_margin) AS NUMERIC), 2)      AS avg_profit_margin,
    COUNT(*)                                              AS total_orders
FROM fact_orders f
JOIN dim_products p ON f.product_card_id = p.product_card_id
GROUP BY p.category_name
ORDER BY total_profit DESC;

-- 2. Profit by Market
SELECT 
    market,
    ROUND(CAST(SUM(benefit_per_order) AS NUMERIC), 2)   AS total_profit,
    ROUND(CAST(SUM(sales) AS NUMERIC), 2)               AS total_sales,
    ROUND(CAST(AVG(profit_margin) AS NUMERIC), 2)       AS avg_margin
FROM fact_orders
GROUP BY market
ORDER BY total_profit DESC;

-- 3. Loss Making Products
SELECT 
    p.product_name,
    p.category_name,
    ROUND(CAST(SUM(f.benefit_per_order) AS NUMERIC), 2) AS total_profit,
    ROUND(CAST(SUM(f.sales) AS NUMERIC), 2)             AS total_sales,
    COUNT(*)                                             AS total_orders
FROM fact_orders f
JOIN dim_products p ON f.product_card_id = p.product_card_id
GROUP BY p.product_name, p.category_name
HAVING SUM(f.benefit_per_order) < 0
ORDER BY total_profit ASC;

-- 4. Profit by Department
SELECT 
    p.department_name,
    ROUND(CAST(SUM(f.benefit_per_order) AS NUMERIC), 2) AS total_profit,
    ROUND(CAST(SUM(f.sales) AS NUMERIC), 2)             AS total_sales,
    ROUND(CAST(AVG(f.profit_margin) AS NUMERIC), 2)     AS avg_margin,
    COUNT(*)                                             AS total_orders
FROM fact_orders f
JOIN dim_products p ON f.product_card_id = p.product_card_id
GROUP BY p.department_name
ORDER BY total_profit DESC;

-- 5. Profit by Customer Segment
SELECT 
    c.customer_segment,
    ROUND(CAST(SUM(f.benefit_per_order) AS NUMERIC), 2) AS total_profit,
    ROUND(CAST(SUM(f.sales) AS NUMERIC), 2)             AS total_sales,
    COUNT(DISTINCT f.order_id)                           AS total_orders
FROM fact_orders f
JOIN dim_customers c ON f.order_customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY total_profit DESC;