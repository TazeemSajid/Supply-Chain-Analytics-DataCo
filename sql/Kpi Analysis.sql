-- 1. Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM fact_orders;

-- 2. Total Sales
SELECT ROUND(CAST(SUM(sales) AS NUMERIC), 2) AS total_sales
FROM fact_orders;

-- 3. Total Profit
SELECT ROUND(CAST(SUM(benefit_per_order) AS NUMERIC), 2) AS total_profit
FROM fact_orders;

-- 4. Average Shipping Delay
SELECT ROUND(CAST(AVG(delivery_delay_days) AS NUMERIC), 2) AS avg_delay_days
FROM fact_orders;

-- 5. On Time Delivery %
SELECT 
    ROUND(CAST(SUM(CASE WHEN delay_flag = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NUMERIC), 2) AS ontime_pct,
    ROUND(CAST(SUM(CASE WHEN delay_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NUMERIC), 2) AS late_pct
FROM fact_orders;

-- 6. Average Profit Margin
SELECT ROUND(CAST(AVG(profit_margin) AS NUMERIC), 2) AS avg_profit_margin
FROM fact_orders;